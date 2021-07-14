Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1623C89E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhGNRk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGNRk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:40:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F33CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:38:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso4355688pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AkN/g8848yQUrVMq0VBpWbOyu8YJObYWSKkoyUzYfiU=;
        b=eMg6FmyNsO6+/sMtxzHj9WXua3i1vPIdUzNZ4lZdQJyej/FRHSIF1ML3Mc0G5cDLWx
         tGwv3//qdXYSpJRjVqTg7jtj4aiFsmzWU90DtlM9Y5q+P+1yJ2rBkswf7mJD6Xo76FEk
         rKQ27JxibdftdRE8B5pWmFRcMUOs3YMz2Cegk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkN/g8848yQUrVMq0VBpWbOyu8YJObYWSKkoyUzYfiU=;
        b=tvkZHIUu8d50fBp99xuB8+uC3yj39nTOGX+YPII5AvX9vz2cB5nLplNfTquVkWey9F
         HhPrcR2fRxxDJKZRGkJBOIXWGPe6q1ABeyqu6mb7RzjV3N4ST4e8aeDBZz53qayJ4Jia
         /Vqyt6Sxg6jddGZGWn1TaRykvFxKzekPkODgBI/y8ss+AFpll+wymircDPsSGtvG/WN0
         uZT8GhKejI/Gk4SPJNFbEyRBcHlcWUHh8H8q46tHtnLkbx3Y4MQoN4BJK7nUZMypCLs1
         C0bQ+vxv4qz4pX5Is6CRG6ty5iXPbCJEULLVAlsFEpVqLuwpbkl2fnmgh0zM+EXye3/Z
         j7ZA==
X-Gm-Message-State: AOAM532PndMNawpBGe1dxMxoIGWefDup4fPwcjytnl/aZSojMYmop47M
        Is5uHqiDa5EhcMIE4zNNHqbhgg==
X-Google-Smtp-Source: ABdhPJwEcCE08Sj3IeUY5ZlR8wzGioKVy8YsVZg+ovQUa2cTdgQKHOv/52is24ZM2pDu/8rkeVCVdQ==
X-Received: by 2002:a17:90a:6a43:: with SMTP id d3mr4872708pjm.15.1626284283944;
        Wed, 14 Jul 2021 10:38:03 -0700 (PDT)
Received: from dev-yzhong.dev.purestorage.com ([192.30.188.252])
        by smtp.googlemail.com with ESMTPSA id d8sm3855074pgu.49.2021.07.14.10.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:38:03 -0700 (PDT)
From:   Yuanyuan Zhong <yzhong@purestorage.com>
To:     elver@google.com
Cc:     akpm@linux-foundation.org, corbet@lwn.net, dvyukov@google.com,
        glider@google.com, joern@purestorage.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm v2] kfence: show cpu and timestamp in alloc/free info
Date:   Wed, 14 Jul 2021 11:37:55 -0600
Message-Id: <20210714173755.1083-1-yzhong@purestorage.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714082145.2709233-1-elver@google.com>
References: <20210714082145.2709233-1-elver@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Timestamp matches printk timestamp format. */
> +	seq_con_printf(seq, "%s by task %d on cpu %d at %lu.%06lus:\n",
> +		       show_alloc ? "allocated" : "freed", meta->alloc_track.pid,
> +		       meta->alloc_track.cpu, (unsigned long)ts_sec, rem_nsec / 1000);

s/meta->alloc_track\./track->/
