Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39934461D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhKEKEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhKEKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:03:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA40C061203
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 03:01:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id az8so8262814qkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y0eDc1jsGrKn0VCcbF5H7UdX+4+t91wUmaywlQWMyXM=;
        b=x1pfM0wbbNiyvInFur0jftbrRutkUjUhdoopeMJQxyUwHRBM6bmAYk7mJgw0MtmSk8
         WkfHRu2bmBkXFxR+iqBzXTN6FSm9Lh5cH01zeYorVX9n4rQrNemN75ZItRntBgxHpZUD
         oENXsa8kTdXdjCAosLc1b//UHi+xSdHYW+cTP1d0NgVFgQI7TKirj2AFAeZH6Rsjwbvi
         u/sYrBn5Ge/s9e43QATW23JoRGqe0bZBZXkHWJrgLxrEsBdMLZWKaU/lQzI/a6vf+2pn
         Zie+UNvz5wEH5J476yv+YvAjsArCjp68Nf5bptEEPBDk+YyhivL6drdCu2GIJlulLZd2
         23wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y0eDc1jsGrKn0VCcbF5H7UdX+4+t91wUmaywlQWMyXM=;
        b=fV2yRY+te0Ndr95K8fuN7IFu7EiiXXf5ImsIkpayooA7EzjB/UAuFE+J2fhpRjbrDP
         FLutHXAW3tRSzp9ENtxukOB+JJsb6ueeSwQyMxvOp065A+hMxrfEdG5gEurkJq8sSRF/
         G6OTu1HZnatmCAgBH6H17OEs+ry9ar38rhs1k1BIabNTNthWujM/6mMCxWm69urA5QS8
         YqEgSa84ovirzJaJteanaIf80fpbrtdx+3MnP6duj2j86aWctPZF+dqtLSPrS0nD1MWC
         3Kv5D8OoLf9VC7TX5/AFmMegyBpxABUanNeTvDwjSi6j5wKJsst1UIMuCfLsMQ4guAa/
         iLeA==
X-Gm-Message-State: AOAM531GZ6n4hqSPkjJ9c0q3fa2OYkGnorMbpjDFUrC1I/77pd2gHo1n
        gIrhFCqTGJ09BrSfBUPjLhBekg==
X-Google-Smtp-Source: ABdhPJyyimvuYtaakCbOwKmFLmiZ5qQtUn+EWJseG+kohZBRl+epslqTJXYEcqwq+0e5UW6mCItUCQ==
X-Received: by 2002:a05:620a:28ce:: with SMTP id l14mr30074240qkp.456.1636106478693;
        Fri, 05 Nov 2021 03:01:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q20sm5276109qkl.53.2021.11.05.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 03:01:16 -0700 (PDT)
Date:   Fri, 5 Nov 2021 06:01:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Wu Bo <wubo40@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Subject: Re: [PATCH RESEND] nbd: code clean for nbd_genl_status()
Message-ID: <YYUA67rq5VHea2HV@localhost.localdomain>
References: <1636000703-13217-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636000703-13217-1-git-send-email-wubo40@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 12:38:23PM +0800, Wu Bo wrote:
> A simple code clean for nbd_genl_status()
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>

This isn't ok, genlmsg_reply() free's the reply, this introduces a double free.
Thanks,

Josef
