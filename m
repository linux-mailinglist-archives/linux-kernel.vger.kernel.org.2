Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3413AED25
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFUQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhFUQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:11:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4ADC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:09:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id v3so10680971ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J4OCVJGrQLe5EEY8W81FSo8uSOepsQU9k2XZodzDKxo=;
        b=dloFBH7MrxD0k1EoHdpizqcM6oEizGBO1rBn3iNK7rWzJrJ4av4aaZ1dYBLvQH2+R9
         NxI4NtvUdwGMpoU7fgb6Nxwm1Zj6mSgPmlcDVnqENR/7CEOaxlTDnKrf6HRc2FuhiRiM
         Se3bGiyvthUuWEUOEcPMTIsVN8y7AbHswWRTId3J6ksPKEKCTNWEOz9F8jdsaH89OU/P
         REz1TdP2JA1Uz53agI91ppTVTh6XY8ja0vRK+yGvB4BS4May2IC2Oh8d7LA0kJYd+sAw
         VCjrb7jLAQnHm4b1KR+V4snnMPbYdPN5fpxHvLKNyMKZDvigqE5CNb2Hu8uWFbpLU8W5
         ntTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J4OCVJGrQLe5EEY8W81FSo8uSOepsQU9k2XZodzDKxo=;
        b=BfGSuRG8TM8nzvDNFV05gHDtVSTC5V2Zla00VDzvGhHGNJXz/sQwlCWIWJHnUmlgM5
         hs0dwzXtQpd5YydDqvAisp/Rj4c6/kxjsKAMfrgnkGugGtbpotyVaO6vuP+2tHhcipBA
         D+VlGvErtBwAoJqo9bIW5gspfwcHaS8MrOv6C3LkAcJylwhlpXjjpqbcyK14s0qfcY2I
         mil0N/Iy/3S2qzGZqO4csGycwIa3gxlKkQff2a4X/OzjKCD28h2I+E+6xCtHHX/tYyW2
         WK16bOOrOd9ujuQm983V+6NkVxytXI/etMfo0IVc8z/Yt0xgAmBLh7thneMGm7KlOIKg
         hNUQ==
X-Gm-Message-State: AOAM532n1Ab9q3Cr9dOkIEGiNI/DVGEtoQlXsETay2L1FUKfMLQ6Ztrz
        q7PCHIqIWQ58IupFTnjYZo1VOIMvDzenNg==
X-Google-Smtp-Source: ABdhPJwEMGQMmejuzmP0roVsVtSuAMP71Aou5hY+G9adaC3dH6FSWe16/YPlMRUceGFO5e6Ul3AU0A==
X-Received: by 2002:a6b:fd12:: with SMTP id c18mr6676562ioi.182.1624291771349;
        Mon, 21 Jun 2021 09:09:31 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c19sm6411060ili.62.2021.06.21.09.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:09:31 -0700 (PDT)
Subject: Re: [PATCH] block/partitions/msdos: Fix typo inidicator -> indicator
To:     Thomas Bracht Laumann Jespersen <t@laumann.xyz>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210619195130.19348-1-t@laumann.xyz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bce2f52e-2d8b-1ea1-c2f6-eaff3c498629@kernel.dk>
Date:   Mon, 21 Jun 2021 10:09:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210619195130.19348-1-t@laumann.xyz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/21 1:51 PM, Thomas Bracht Laumann Jespersen wrote:
> Just a fix for a small typo in msdos_partition().

Applied, thanks.

-- 
Jens Axboe

