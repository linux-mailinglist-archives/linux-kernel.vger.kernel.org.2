Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A954930C212
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhBBOjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhBBOcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:32:08 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302ACC0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 06:20:16 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q5so19152580ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1KFZQVY/DxQ9liNlk4p5rHsTe1eztkSWG9pZLclAaM=;
        b=Roe+D204Ctd0npf37Ni88h2NOvgV6xaroR+sXYPETApFsoi3natQ82RzJtyfetiH1B
         xKjRZ9xOv73sQOXuTZIv0Cvxk4TvlcmI3HLnxu7j7lEY8zm/CUp7TRiuf5RPwHf0pSFo
         AC0/fAjcViva9q1JJjys0qAYFvLxqXHvetYiqtHFq/DMtv1fDDN7IGm3CyT3D5lAsTGJ
         C9zheHWkl4bUZbZ77ZDeeQCNE6BWSabVLKcpe9VLHxhYolYY7rL6r2i3kqldDzkMVWq1
         zL43j+s4WZZnqIhUKrcXj5ds6pK3Ok6peFO8tTpUI8f8brdDU+yy2OvOvHhd9+Yby0NR
         YRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1KFZQVY/DxQ9liNlk4p5rHsTe1eztkSWG9pZLclAaM=;
        b=PJCUSoMRubdwFPCTIW+9Jszv3jCHK25ASCrtnh0mG4TMadTyl4l08pA+bquQTHNpkU
         jnQR7boSF7m6AJA0wLaVIHzxX2Cl9M0ijUOZ/MtTiY1mSb56v5CFsGwjQtcx+qaRUCol
         gj2YInuMY7KGVh2Mfm2DyDIWsqTTu71eN+F9it/sp8Di7kmNWhlg6CYXcmklyDLRs1bX
         jtTnioGA0+UHy7gATbv80i7lcXWB4KiBtS6QnkuluEZB8/871nFB79d5+p8/0exlmKhj
         h+pHIG8sVxxUm1ZIaIUZ5NnuTawVh3EcUeh9HSmuypeFjZJSD787IUMmfnGbRXTXKVfr
         RaEQ==
X-Gm-Message-State: AOAM532P3dkjqjc9HhG4FQb/w95ZI35SauKZWZfNiH8ayVhYaF9/S0kT
        xlWyUzGQdmdqYrQHb7quz7icNA==
X-Google-Smtp-Source: ABdhPJxkdEchUAvYW/rkyrEcHpNi1VxOF9nH09cLjhcdz49G3SRvbrpf5/5CT4BvCNo00Q78q87qZQ==
X-Received: by 2002:a05:6e02:b2c:: with SMTP id e12mr17301468ilu.143.1612275615609;
        Tue, 02 Feb 2021 06:20:15 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p19sm11005722ilj.37.2021.02.02.06.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:20:14 -0800 (PST)
Subject: Re: [PATCH] Revert "bfq: Fix computation of shallow depth"
To:     Jan Kara <jack@suse.cz>, Lin Feng <linf@wangsu.com>
Cc:     paolo.valente@linaro.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210129111808.45796-1-linf@wangsu.com>
 <20210202122836.GC17147@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f92a55b4-0743-a700-8296-e739f4fcf093@kernel.dk>
Date:   Tue, 2 Feb 2021 07:20:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202122836.GC17147@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 5:28 AM, Jan Kara wrote:
> Hello!
> 
> On Fri 29-01-21 19:18:08, Lin Feng wrote:
>> This reverts commit 6d4d273588378c65915acaf7b2ee74e9dd9c130a.
>>
>> bfq.limit_depth passes word_depths[] as shallow_depth down to sbitmap core
>> sbitmap_get_shallow, which uses just the number to limit the scan depth of
>> each bitmap word, formula:
>> scan_percentage_for_each_word = shallow_depth / (1 << sbimap->shift) * 100%
> 
> Looking at sbitmap_get_shallow() again more carefully, I agree that I
> misunderstood how shallow_depth argument gets used and the original code
> was correct and I broke it. Thanks for spotting this!
> 
> What I didn't notice is that shallow_depth indeed gets used for each bitmap
> word separately and not for bitmap as a whole. I'd say this could use some
> more documentation but that's unrelated to your revert. So feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

I don't have the original patch (neither directly nor in the archive), so
I had to hand-apply it. In any case, applied for 5.11, thanks.

-- 
Jens Axboe

