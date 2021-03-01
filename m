Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4332A02B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575437AbhCBD4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbhCAWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:45:58 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF900C061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:43:32 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id q85so18395878qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJPW6pgVYCP6/a/70cVXkfMzXshOTQJL9A2AiPS8QgI=;
        b=Bx6umze/cD1yKXlg/5KpVF6OkZsS+2Ixi9nNk3a58P3PJq4mZNH5M4/oo27xzrTQiM
         ZKDa0UucUS49FjIrbYEBQDQNw/jUIpocA0GCrWFuHvsJwWmOqlYCHdnyIqQ29Hc+27Hr
         Q/zlzJo8qAUwxTA7IW9pjFFjEqaFlyNLyTvI5f2S2T9puj+sWWGEZPl7RKI2HyPSnfLp
         ijM9p/pBs650xF9ycatGuwIDXhPH9ZhVpf6n9EdizZ4s8N7S3uKF0nqaSAQHHADs1fR1
         XVRscFCYgveZv8k7dInrev3lfX5eU1xfUsOM4vPo+sF85n8SeotZJsA623TUZwGDXCIj
         32MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YJPW6pgVYCP6/a/70cVXkfMzXshOTQJL9A2AiPS8QgI=;
        b=Yito2hNzy6ECvaCp7ZfFWOVBav2qRf7eLGfpFNpOgSBcaCY53ovTC6y4DwFvA2fYkd
         gcbcd5bWU6TOIlQqu9HT/WYq1b2TEWuNMk9i+2YqQuEFGXn/QmbUxydP9Q0j2GssYa7R
         k3k1f9bo9bFzOxmX07OSkDHjMKU97KsROMKUMY0XX3y8lMd/gaip/Zk9/m4NXI3Mfezp
         RvAtw+Iy1uq8gQ+rapqQU2UaUl6dpxCVUc1kN6HqsJW/Axnrtc4komjQ166PfWq/RkGa
         LiJ/IydZOAYKD/bVaYlcAqBtqltGjVL+VQ4ukN6QsncW+NcjkWHVAHG30mMD6l7NF4V/
         XuyA==
X-Gm-Message-State: AOAM531DA58UeeTX3767rQ69n+v9mhWDLolhp4SLG1xF/mv2w+SyAyrE
        uTO/t9tnVIpSnqIYOlKNclY=
X-Google-Smtp-Source: ABdhPJwUKD9LyQu8sXWtXvbSePxFbhI35chpmaecruhhZBL06tB7Vxh1URKC23NMUpPK1+Y9H+Qx2Q==
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr17312691qkn.273.1614638612101;
        Mon, 01 Mar 2021 14:43:32 -0800 (PST)
Received: from localhost (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com. [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
        by smtp.gmail.com with ESMTPSA id z31sm12834974qtb.0.2021.03.01.14.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 14:43:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 1 Mar 2021 17:43:31 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Saravanan D <saravanand@fb.com>
Cc:     akpm@linux-foundation.org, mingo@redhat.com, x86@kernel.org,
        dave.hansen@linux.intel.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH V6] x86/mm: Tracking linear mapping split events
Message-ID: <YD1uE1lYRFI5tm8l@slm.duckdns.org>
References: <20210218235744.1040634-1-saravanand@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218235744.1040634-1-saravanand@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 18, 2021 at 03:57:44PM -0800, Saravanan D wrote:
> To help with debugging the sluggishness caused by TLB miss/reload,
> we introduce monotonic hugepage [direct mapped] split event counts since
> system state: SYSTEM_RUNNING to be displayed as part of
> /proc/vmstat in x86 servers
...
> Signed-off-by: Saravanan D <saravanand@fb.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Andrew, do you mind picking this one up? It has enough acks and can go
through either mm or x86 tree.

Thank you.

-- 
tejun
