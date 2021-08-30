Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82433FB238
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhH3IHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhH3IHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:07:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E10C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:06:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p38so29678727lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/rqmMsuVC/4+tn8xkykTg6rWz+8uejNw//LxydQyIhI=;
        b=AjS7DrEFhqLYkAZnpxuqDducOWBXWg5mKW29ikB6PuRhpGFLvqEfaCuwyzcNzcqz5K
         58NuNBJH/K7LuofKqECT1sLf5QYRDWUR47GBMaEDQvjOckOuLceLUiHedHxJkjUrnM5J
         NBLMPm/63XiWL+Mt9hukI2YP+n+wr/QuZvw0r1DZzvc7dTQFH3IgxpNCT6tGQ6it9LWo
         m018BNElX8hKd8SNph424S/xLIcqwcS0zEfd+TYRg0adrIIK8PxwblPdJBAKgUycoI3U
         8j3Z2U4oZZkKbEdD6RlrrAZyYnhAjWfdwDp1Ez/f2fSKWgeT5b3YINRzbYRLnCSt6qRA
         vogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/rqmMsuVC/4+tn8xkykTg6rWz+8uejNw//LxydQyIhI=;
        b=dFMEf2csYc8AqkuAy0mqidKokgXJIDJ92BsSLV93qLEgcZtsIG5/2FlotamU+DSC2h
         lR3hyOn0QmQqfSKDLHWg6OHzDPAKtzl1NsuqqOXPeeL8yUVMMmeMUJsA/iG6TW5Scciy
         viJHMV0tNhZz8L47ckdqRvf/Ku5jfUKBZ6Cdtrv14Xwqm/7X6CXSDHheTw0m1tw5o06a
         yJuDdIwubz82R9s31DWROfVP5QkcBr/1YO8DILWsNMaKouL7WvMFmpbzGbkkK7W4bUc6
         Asda2UpesYLmJy0Gfq4Zs1itQrxvWDTtwa+EK0wqu007mAEdkshxPIQs7UqH3wmi/QkX
         WETg==
X-Gm-Message-State: AOAM533ur5T+1oHItj+y0ihduE9o88SBrXbeA6R90IQWam+B2GRKBFbz
        Ozz740HPV7ijRtNAvhHtkyIdaKQt+Oc=
X-Google-Smtp-Source: ABdhPJyyg/d8lMpc+kOn7+9kx9Y+q25tktE2/HxA5iYsTCyW1On0C+VCo4gGb5vVJtwE83XUZs114w==
X-Received: by 2002:ac2:5df6:: with SMTP id z22mr16583226lfq.645.1630310769805;
        Mon, 30 Aug 2021 01:06:09 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.213])
        by smtp.gmail.com with ESMTPSA id o10sm697278lfo.207.2021.08.30.01.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 01:06:09 -0700 (PDT)
Subject: Re: [PATCH 2/3] staging: r8188eu: simplify c2h_evt_hdl function
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210828212453.898-1-phil@philpotter.co.uk>
 <20210828212453.898-3-phil@philpotter.co.uk>
 <19b08be7-964e-fdbc-93c8-825ad41e1ade@gmail.com> <YSwVwKdJaj3EcW5V@equinox>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <68ebbffe-62cc-5fcb-1fca-e96a1e9dc822@gmail.com>
Date:   Mon, 30 Aug 2021 11:06:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSwVwKdJaj3EcW5V@equinox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 2:18 AM, Phillip Potter wrote:
> On Sun, Aug 29, 2021 at 02:54:14PM +0300, Pavel Skripkin wrote:
>> On 8/29/21 12:24 AM, Phillip Potter wrote:
>> > Simplify c2h_evt_hdl function by removing majority of its code. The
>> > function always returns _FAIL anyway, due to the wrapper function it
>> > calls always returning _FAIL. For this reason, it is better to just
>> > return _FAIL directly.
>> > 
>> > Leave the call to c2h_evt_read in place, as without it, event handling
>> > semantics of the driver would be changed, despite nothing actually being
>> > done with the event.
>> > 
>> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
>> > ---
>> >   drivers/staging/r8188eu/core/rtw_cmd.c | 21 +++------------------
>> >   1 file changed, 3 insertions(+), 18 deletions(-)
>> > 
>> > diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
>> > index ce73ac7cf973..b520c6b43c03 100644
>> > --- a/drivers/staging/r8188eu/core/rtw_cmd.c
>> > +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
>> > @@ -1854,27 +1854,12 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
>> >   static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
>> >   {
>> > -	s32 ret = _FAIL;
>> >   	u8 buf[16];
>> > -	if (!c2h_evt) {
>> > -		/* No c2h event in cmd_obj, read c2h event before handling*/
>> > -		if (c2h_evt_read(adapter, buf) == _SUCCESS) {
>> > -			c2h_evt = (struct c2h_evt_hdr *)buf;
>> > +	if (!c2h_evt)
>> > +		c2h_evt_read(adapter, buf);
>> > -			if (filter && !filter(c2h_evt->id))
>> > -				goto exit;
>> > -
>> > -			ret = rtw_hal_c2h_handler(adapter, c2h_evt);
>> > -		}
>> > -	} else {
>> > -		if (filter && !filter(c2h_evt->id))
>> > -			goto exit;
>> > -
>> > -		ret = rtw_hal_c2h_handler(adapter, c2h_evt);
>> > -	}
>> > -exit:
>> > -	return ret;
>> > +	return _FAIL;
>> 
>> 
>> Hi, Phillip!
>> 
>> 
>> Do we really need to return _FAIL every time? The only one caller of
>> c2h_evt_hdl() does not rely on it's return value. Shouldn't we make this
>> function return void to simplify the code?
> 
> Dear Pavel,
> 
> Thanks for the review. Good point on the return type, I'll publish a v2
> series.
> 
>> 
>> 
>> BTW, this function does nothing now, as I understand. It reads to local
>> buffer and returns. I think, it can be removed
>> 
>> 
>> 
>> >   }
>> >   static void c2h_wk_callback(struct work_struct *work)
>> > 
> 
> Not sure if you're referring to c2h_wk_callback or c2h_evt_hdl, but
> either way, they both call (indirectly or otherwise) c2h_evt_read and
> c2h_evt_clear as well as rtw_c2h_wk_cmd in the case of c2h_wk_callback.
> To just delete them wholesale therefore would be unsafe I think, due to
> the effect on event semantics.
> 
> Certainly, it is possible to handle this c2h stuff by just reading from
> register and ignoring though - another series is a better place for that
> though I think. Admittedly, I may be talking nonsense here :-)
> 

I was referring to c2h_evt_hdl. I missed, that c2h_evt_read() writes to 
register, sorry :)





With regards,
Pavel Skripkin
