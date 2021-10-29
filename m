Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1B43FE83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhJ2Ogp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ2Ogo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:36:44 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F51AC061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:34:15 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s1so7848291qta.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XiM+B9qyPSJmz+1nGIcnoNS9xSSaJAUzee605rT86OM=;
        b=X34VJuP893dPnyKj7tKDZS5M8bu1vj5GUEbKqC0ehlOgup3it/mOc80zNH2MD7O5sv
         L6Sok1uA+G0ndCy/c83EQ25tJbqOJtJ+sWgYAEywCf+ODAJyahVsmS1V9Ya1uXi6P4dC
         9ROX96pWoQaIrPqYl17HUBgUBvM5U/qqKvGfg1uly5yQsv70bZo4C2jIj4glbnGDmot4
         XOyoyqzgMiMF+keg6zrOiKfwYEMBxCG4F8wVzYK93GabPXiPZC8vp3jOzx1lhuqgzlGz
         fh+Z0QQ0bvFp5KF/7DTgS5aG0LV3rQOI6ktMEFTXGWZr7W5Yff2fvK/rCTo9VS+bjGL3
         gMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XiM+B9qyPSJmz+1nGIcnoNS9xSSaJAUzee605rT86OM=;
        b=u2D+KidWZLE35yXZpmCLdW3eBM8FKPRGvQJK/AlSVN8KW0t3R0dIOTuunHTI1/qzbe
         eZAJNmRFQKmWY+y9J34r+8zyNyWh7yhmYyGj17Th1E5qoYOhXIAIrSi9kzb6ca8GOx+Q
         289MIDJ0VsUTYEGUEz7jfXmzQopFHANN+CDIvWWB1mGWOAX/UKRWcVGD6tu7DaYfekKm
         D11udF8KWkX/3I12dESWJnVnV2DF9thHDcmQa5ihjdiopBAQqy1zelKhWWqDUxSGuypx
         mrd5a2tvN9XuqeQXIDsa4Bxk70rYzv/r+ZscQJslEWcsfWOKb9y/mNYUkVEkZP97T2Ge
         osKQ==
X-Gm-Message-State: AOAM532dAEZXhqm0mFf1+o/HhSzSX03Tnl+mH9mYaJpAOzx03F9VcsLI
        1upAPLW5UCRgDc/KiRH6uVyaoM6DdZ55OA==
X-Google-Smtp-Source: ABdhPJwT0NumwZK7MrMRroChOnTroI0bTN/bQxliWUiDYlevjctMF4EdTbVW+0hQZXtexw4bI8eU1g==
X-Received: by 2002:a05:622a:28e:: with SMTP id z14mr12014795qtw.24.1635518054536;
        Fri, 29 Oct 2021 07:34:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a15sm3925121qkp.17.2021.10.29.07.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 07:34:14 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:34:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3 1/2] nbd: Fix incorrect error handle when
 first_minor big than '0xff' in nbd_dev_add
Message-ID: <YXwGZL+VIRhKwEgi@localhost.localdomain>
References: <20211029094228.1853434-1-yebin10@huawei.com>
 <20211029094228.1853434-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029094228.1853434-2-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 05:42:27PM +0800, Ye Bin wrote:
> If first_minor big than '0xff' goto out_free_idr label, this will miss
> cleanup disk.
> 
> Fixes: b1a811633f73 ("block: nbd: add sanity check for first_minor")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
