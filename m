Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12B1363C72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhDSH1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhDSH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:27:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4803C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:26:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e7so23859608wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2BaP8TWvorcR2IXXU9ccES/WVlUvsF3IFm5ixOqLO3o=;
        b=VnNUxmSp7rV1E+zt9+v9bbnrLQj2oLUH6GDzULyEn6CsIIuC2iJhE9pdqhq1y1KDdh
         3Jc3LYi8xkNFCs2oNuIKGuVXcXbL/Wh4zGgoCjaWS9QzdNPmPn286/NM+SkWvmbuY6Gu
         g3R3j2cmPVF+NH1jCDNLXsqPIL6YYEjLlXQJ/Qpji1qKlaX3tMMkGELYdqaQvCnQG82+
         grWr+iS8nLaPuFepAqCIg+5XyN4qx3zqU6Ud5lOabUUuUQ7L5jS4489p9ja0aV9NPi6u
         An+OvxWaovvgq/epfyLNuIv2ESxcKg5CJfEcZFUcp9zKseNViMxm3skm2GCfkF4Osn0k
         otzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2BaP8TWvorcR2IXXU9ccES/WVlUvsF3IFm5ixOqLO3o=;
        b=mOrLdLRn3o4yRFil2wslbPbpJPbNw1xurisLZV1T/aRmuaZUXitsFLeUXt/HspX7k6
         1OgrXlFPkeeEU8kLTqaMMwaeRar2Lx4AB47su2wu+D5jL7Y7l20xvrbLa8jOmkBfoBRI
         XG5Z6pTchYimcF2VE6mDftwOSCGSP+IzUCFlO4Lac5OPQHfN3cx7kk7RtzZBrp4WivQQ
         +qRqBLCQ0dl3hV80chvSV13ZkwfKR7907bAbVoYSRtnKDiVaADmBGpmxtV6GpCZzBjA7
         ipwLu/NO8WKe/dn9Ul4/3AqGAHFKlHVyDLo7iEK4D5rGYN7T/DQih7yDRwZiO+m1r2DC
         6kbQ==
X-Gm-Message-State: AOAM530ekA5j9DXiVMMN5YVB0zuviQRoJRwt6AWGO0w2GPDwr/vSWkZV
        ew76tGMFR5Go9hcniJzYfnldTQ==
X-Google-Smtp-Source: ABdhPJxiB6PCNMvbcsVLql5kAlV60E/PKSrqhL/E5Cjb7JzKzneD+W19Bc+ZeApiSVEfX0mGnHTkGQ==
X-Received: by 2002:a5d:5711:: with SMTP id a17mr12824723wrv.342.1618817204632;
        Mon, 19 Apr 2021 00:26:44 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s64sm18910767wmf.2.2021.04.19.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:26:44 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:26:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        cluster-devel@redhat.com, David Howells <dhowells@redhat.com>,
        ecryptfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Michael A. Halcrow" <mahalcro@us.ibm.com>,
        "Michael A. Halcrow" <mhalcrow@us.ibm.com>,
        "Michael C. Thompsion" <mcthomps@us.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        "Trevor S. Highland" <trevor.highland@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 00/31] Rid W=1 warnings from GFS2 and EncryptFS
Message-ID: <20210419072642.GD4869@dell>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
 <20210419050926.GB405651@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210419050926.GB405651@elm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021, Tyler Hicks wrote:

> On 2021-03-30 17:44:27, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > There is more to do in filesystems.  Another set will follow.
> > 
> > Lee Jones (31):
> ...
> >   fs: ecryptfs: read_write: File headers do not make good candidates for
> >     kernel-doc
> >   fs: ecryptfs: debug: Demote a couple of kernel-doc abuses
> >   fs: ecryptfs: dentry: File headers are not good candidates for
> >     kernel-doc
> >   fs: ecryptfs: kthread: Demote file header and provide description for
> >     'cred'
> >   fs: ecryptfs: file: Demote kernel-doc abuses
> >   fs: ecryptfs: super: Fix formatting, naming and kernel-doc abuses
> >   fs: ecryptfs: messaging: Add missing param descriptions and demote
> >     abuses
> >   fs: ecryptfs: main: Demote a bunch of non-conformant kernel-doc
> >     headers
> >   fs: ecryptfs: miscdev: File headers are not good kernel-doc candidates
> >   fs: ecryptfs: crypto: Supply some missing param descriptions and
> >     demote abuses
> >   fs: ecryptfs: mmap: Help out one function header and demote other
> >     abuses
> >   fs: ecryptfs: inode: Help out nearly-there header and demote
> >     non-conformant ones
> >   fs: ecryptfs: keystore: Fix some kernel-doc issues and demote
> >     non-conformant headers
> 
> I've applied the eCryptfs fixes to the next branch of
> tyhicks/ecryptfs.git. Thanks for the clean-up!

Thanks Tyler, much appreciated.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
