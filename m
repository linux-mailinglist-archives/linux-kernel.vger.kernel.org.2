Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F333FF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhCRFzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhCRFyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:54:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB5C061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:54:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t18so2336498pjs.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rJROOKajOtciafbi5yKM+xYoRKUUdF2HFDVh5pjYjDc=;
        b=V3a61EFeK8DCdYgpexeyYbDeJ6iJDfdbxjAeD7lChv/gRGorl33DJ3BMUviRPySs58
         DqijCIGczHsOaQVQTiwCTUbFxa8OJ6lH/P01tnCJpz/Gr5aQL2Nif/8XBHB5io4qZOGI
         LQyqTdOAUqrjefaJTahNsu8cRz7TQMUn4rLa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rJROOKajOtciafbi5yKM+xYoRKUUdF2HFDVh5pjYjDc=;
        b=V1KF5a0BQVvx9TSiS1BbVMmq2mBtqXNYZ+7vReiIb0yi7Z649r88l8olFLlIjS//7K
         znOjYzZv8cq//htyW2MBSiUQTeKpoGP7LHzy7637um8YA+NAR/S5GIBZ/NvsR87b/jvU
         /9NKPu4WCOJ6DYtp280PWV6k37eq4svAOLjZ8pJuuZOmoT0hP05Ly0qvlEMFvLqdDDpF
         IHZ9gSVJx8auQ8KwWhTX0oYuLg9hFPtRTiSAYeAsuD6FEoVRlQhGMSMoZ+Jrh+AzbqJe
         eukWRi0mDe2RJvd6H6zqdjury930HzWi+jTIAWtQatkAgC+ervopGNqP2/I87Gwjjn3a
         98WA==
X-Gm-Message-State: AOAM530bBzzLKurVJX4rBF6ivnqNbo0UM2ANGHmJ3jx7gTHErsn6QGEm
        zvuO2B2BrEEiB7JNs2PJUmi4Uw==
X-Google-Smtp-Source: ABdhPJyfFKA4Cehmeh/BMzSXGkh4TwwBYXL3HOfY3RvVilv2kLybdPLaFSKBIWTPt29ZHHbUQvDtrA==
X-Received: by 2002:a17:90a:5284:: with SMTP id w4mr2464303pjh.29.1616046875626;
        Wed, 17 Mar 2021 22:54:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y24sm884896pfn.213.2021.03.17.22.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:54:35 -0700 (PDT)
Date:   Wed, 17 Mar 2021 22:54:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, surenb@google.com,
        minchan@kernel.org, hridya@google.com, rdunlap@infradead.org,
        christian.koenig@amd.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, Helge Deller <deller@gmx.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RESEND PATCH v6 2/2] procfs/dmabuf: Add inode number to
 /proc/*/fdinfo
Message-ID: <202103172254.478DE154@keescook>
References: <20210308170651.919148-1-kaleshsingh@google.com>
 <20210308170651.919148-2-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308170651.919148-2-kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 05:06:41PM +0000, Kalesh Singh wrote:
> And 'ino' field to /proc/<pid>/fdinfo/<FD> and
> /proc/<pid>/task/<tid>/fdinfo/<FD>.
> 
> The inode numbers can be used to uniquely identify DMA buffers
> in user space and avoids a dependency on /proc/<pid>/fd/* when
> accounting per-process DMA buffer sizes.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
