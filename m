Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE0E3A5F33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhFNJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:38:12 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:46078 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:38:11 -0400
Received: by mail-qt1-f178.google.com with SMTP id l17so7988834qtq.12;
        Mon, 14 Jun 2021 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=BwLjKWDoIuboclHNzBKSWqFVNk7NANaHk7eW7w1fojQ=;
        b=NSenXLth4ExLalDSsPdx1a/0En/1GiMUEWVLE1c9oTCt+ltSE6PoiCUjw4wRTXnWv8
         dbdvEmd0Zx2cyggbnePNGBTVsFhSS2X1gRmVyAB1i8Tf0Hx5j9aVFZSyXehXtFRlqqh3
         mhhf3NgoE/37JgviAQIln2r595REzo0HjIO6InwZsSooBuRPKxAcJ0FKiXtyco6DjYtx
         mEa46nX9g8A5kBiFkN+61MEpTJo1XHVnCmdUOdCXeenBTOIU0CftMAI9M60WCOYY4Mkk
         3aynH5wpJNNZEg/flyDwcmD35qtwLsM339I+wYcfoNCxHQA7jCW4dqoV8RBE9aQvsO/y
         rM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=BwLjKWDoIuboclHNzBKSWqFVNk7NANaHk7eW7w1fojQ=;
        b=rdB8epFh6M1Dk0aWYaNPJjd2l/bSjSp5sEn3fUE4w0/COuBNrbQc1GVkdf8IOTFzI4
         yLoUkEKnuEYEoL1WmIWDn3ncJ70rgWeAcTUtn6YrtfYrMJ/cITojYx1FTp0/gKlFZy7B
         9E0ZGv6lUuUiys8EZPWtiIZ0b+nQdwoJx+jgDYjRl58p5eXQ1o3daank+J9e85IcmqSo
         rq85gX4/UkopD1vhPuotExHBbRhA3CIc3mh8zPG17BMWXQwgJHGR30z4DpjRn/6qdcMK
         oNdHgoM+PLdH9Z380VlXI2WFSERipxAaIbs0Vcbi0fawRfebggpy2E6tkPGQW9PiC65B
         5BLQ==
X-Gm-Message-State: AOAM532xXzcbatCZ7UB5k7tjReHtiWhEWiBsu7XWy7RRzWVq14aJRIyA
        9OU9VNNrCVtts8TfVuKqr2A=
X-Google-Smtp-Source: ABdhPJxPDuTJ9Z4g2Bn1ljNEHiu6Qv3EmX7yNvDm1YA4tZMupp6hTU8Gh8HJK1CkfnCzIOwLaL2blQ==
X-Received: by 2002:ac8:5558:: with SMTP id o24mr15734991qtr.18.1623663308342;
        Mon, 14 Jun 2021 02:35:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h12sm9397095qkj.52.2021.06.14.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:35:07 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     sieberf@amazon.com
Cc:     sj38.park@gmail.com, Jonathan.Cameron@Huawei.com, acme@kernel.org,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, linux-damon@amazon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sjpark@amazon.de, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com
Subject: Re: [PATCH v29 09/13] mm/damon/dbgfs: Support multiple contexts
Date:   Mon, 14 Jun 2021 09:35:02 +0000
Message-Id: <20210614093502.16797-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <98a75d0c-2d1a-807e-050b-fb8e7d92f447@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Mon, 14 Jun 2021 11:30:12 +0200 <sieberf@amazon.com> wrote:

> +    new_dir = debugfs_create_dir(name, root);
> +    dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
> 
> debugfs_create_dir might return ERR_PTR, should this be checked?

Greg, the maintainer of debugfs, recommended to just ignore that:
https://lore.kernel.org/linux-mm/YB1kZaD%2F7omxXztF@kroah.com/


Thanks,
SeongJae Park
