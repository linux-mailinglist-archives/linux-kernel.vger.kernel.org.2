Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA93B5F55
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhF1Ntk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhF1Nti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:49:38 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F634C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 06:47:11 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id g13-20020a4ac4cd0000b029024c717ed8aeso1648015ooq.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qceIscsR0qrG5qBxyFH8+s8zOb1JhNM9G4ZV0IV+llI=;
        b=Ui5tbzleCKtxQLzeaeNusdncvAYbZ0YVOaGFOd9hPcTFcKVdYk3QY7gbBOjNaFJN6v
         BTKz1fQcFColqlgOehqK1lCndPtgfQ7g5E07dU8Ga6wHXAqFg1S62r3U7snNJAGS8awD
         VE0Bv+6UzQCojhJjbb+wdf5OQpg2M6RJaulStQP6nxup6C4jaL+/ljjWn1OL10iv5ofs
         PsOum6XwhXMAILXuiX/Xl38nrmFKYNGiN5pDMRX0LYIEDwsIsiIXxwRhXJqwufJnfwSB
         nUsHJ2JeGNdd6Z9YeVWdo1+VFc+QPUboRwHfLrsLGKXIak/048eDNKCJ59FydZXXbb6Z
         WJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qceIscsR0qrG5qBxyFH8+s8zOb1JhNM9G4ZV0IV+llI=;
        b=l/CZFyS51UPwrneYACxMpOI/SuQZYi6ahPRM44IhnJ49+Tv9koVcs6YBSHsIFTmu8X
         YTRsHjZwBMA9nLxIC6598KrrOXqtNNWrtecs+sNwCdoddZOcjJfQ6lc5oGcq1wxinohQ
         LkrDN5fshPH9NZaN5DFd5zVBokLsEQdpT9VUWFd7MN2ZpzeZmnQbI3N9zqoY0W6CFA30
         PJarcpSd9OVA3otFXcF+hlQlKsqZ7PaGOdNemCx5Jd9VB4SPTqVpfG2MA41x8JOwbkRx
         +XDB7xGt7Pvdimdqom8FyR3JceikqCdE7K7kajBToRuUHLNMfUwAxEExjeH7LcGDBv/x
         YDjw==
X-Gm-Message-State: AOAM531R5uAgbd4g25wS+N+axIIbt5Q3b7fn3U0GCCDDfYZg/xwNmgsK
        qZwWWXwtkoTtEGn+3ErYHAzaZ2mWEexmuK05
X-Google-Smtp-Source: ABdhPJzW850hkyCet8ockBb2pXWxsK9Q32fy3TmhkXzxvuk4dJrRBVxkfdylqxd+lYT1oDAev5TCSA==
X-Received: by 2002:a4a:b815:: with SMTP id g21mr19202867oop.70.1624888030261;
        Mon, 28 Jun 2021 06:47:10 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id y20sm1619791ots.23.2021.06.28.06.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 06:47:09 -0700 (PDT)
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210623133205.GA28589@lst.de>
 <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
 <20210628133858.GA21602@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <4d6b7c35-f2fa-b476-b814-598a812770e6@landley.net>
Date:   Mon, 28 Jun 2021 09:04:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628133858.GA21602@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/21 8:38 AM, Christoph Hellwig wrote:
> On Sat, Jun 26, 2021 at 05:36:08PM -0500, Rob Landley wrote:
>> On 6/23/21 8:32 AM, Christoph Hellwig wrote:
>> > Hi SuperH maintainers,
>> > 
>> > I have a vague recollection that you were planning on dropping support
>> > for non-devicetree platforms, is that still the case?
>> 
>> We'd like to convert them, but have to rustle up test hardware for what _is_
>> still available. (There was some motion towards this a year or so back, but it
>> petered out because pandemic and everyone got distracted halfway through.)
>> 
>> (We should definitely START by converting the r2d board qemu emulates. :)
>> 
>> > The reason I'm asking is because all but one users of
>> > dma_declare_coherent_memory are in the sh platform setup code, and
>> > I'd really like to move towards killing this function off.
>> 
>> Understood. Is there an easy "convert to this" I could do to those callers?
> 
> Well, the replacement is to declare the device memory carveouts in the
> Device Tree.

Your plan is to eliminate the ability for non-device-tree boards to do DMA?

Rob
