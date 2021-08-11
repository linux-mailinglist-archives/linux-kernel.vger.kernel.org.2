Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D23E96AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhHKRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229976AbhHKRTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628702366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d84eWNPdM5Ha44o42ECV+3RPeoNKKVVxElIlAa+H45Y=;
        b=hBVNwuHfiHjL4JgZs9wiKICvCEooCKBY/sJ7/8U+esoNhYepCNXrLtwi9Sio5mOZ8lYfdy
        SilvBA2VR+9LyJDX+juRgnYfSy1HVpzhQO3UvxhWaXiuSWXLgWyxQ/ES1EzDu4b8RQY/HZ
        mxirAMNoVho6j5EGivBAuexXfPu457g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-RC7DBvOqMRO2Y7HaFN51GA-1; Wed, 11 Aug 2021 13:19:23 -0400
X-MC-Unique: RC7DBvOqMRO2Y7HaFN51GA-1
Received: by mail-wr1-f72.google.com with SMTP id e17-20020adfa4510000b02901550e0550f3so979605wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d84eWNPdM5Ha44o42ECV+3RPeoNKKVVxElIlAa+H45Y=;
        b=Kf9Gahy6e7Qe0CvAiALHw8zO9LAdaBv9HthWR7YWQ/WeRkiIfgPlUi+rLagMZRts4/
         EwFpM2AEqkMlwjzG63WPvi1ourEBL7Zs+GCy+oPWrnKe9sDUZcM7gBdoxhfGHsldUISl
         utXQBrvPh5fFEr6/LIUe9y2g1vN/CbKkHnN61Rkl5DkX1CkIoPbZHrunR6IWTn7lS8GX
         +yGpzS1bnMtX5c5NHXvdB7oLOfLQdgJJtfAluMljvIBV7sj2FMRyGKINzLTy+PaJiCPQ
         qgXS2TnnlMO9Edw5MekseEtVFTbttMYFmGeIiaoi9wmYlylj06puOXTo9H0sspO+aQmn
         C5WQ==
X-Gm-Message-State: AOAM533T1Dx+CO2dtea04edmDQeXSsRjF2vDcwlS/1Za9Ejdr/uIziM3
        caoGoPzzntQq01r1RhOdRjXoyIHlQZGQ0t0gLPWslUsm+CIez617CUmy5JzBg+Up7BTFFBmZR+9
        8s/vfe9YgksF1IavsFNjDYTSl
X-Received: by 2002:a1c:7203:: with SMTP id n3mr11411946wmc.45.1628702361726;
        Wed, 11 Aug 2021 10:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz65N6gjPfNeWCKRnWatJd6LMokcZxiGHmWAabZY4bIv75S+yMOn/S4zYL91Bqxdk4FEm0zyg==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr11411935wmc.45.1628702361535;
        Wed, 11 Aug 2021 10:19:21 -0700 (PDT)
Received: from pc-32.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id j6sm12356971wms.44.2021.08.11.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:19:20 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:19:18 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: Add rtnl attribute IFLA_PPP_UNIT_ID for specifying
 ppp unit id
Message-ID: <20210811171918.GD15488@pc-32.home>
References: <20210807163749.18316-1-pali@kernel.org>
 <20210809122546.758e41de@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210809193109.mw6ritfdu27uhie7@pali>
 <20210810153941.GB14279@pc-32.home>
 <20210810160450.eluiktsp7oentxo3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210810160450.eluiktsp7oentxo3@pali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:04:50PM +0200, Pali Rohár wrote:
> On Tuesday 10 August 2021 17:39:41 Guillaume Nault wrote:
> > On Mon, Aug 09, 2021 at 09:31:09PM +0200, Pali Rohár wrote:
> > > Better to wait. I would like hear some comments / review on this patch
> > > if this is the correct approach as it adds a new API/ABI for userspace.
> > 
> > Personally I don't understand the use case for setting the ppp unit at
> > creation time.
> 
> I know about two use cases:
> 
> * ppp unit id is used for generating network interface name. So if you
>   want interface name ppp10 then you request for unit id 10. It is
>   somehow common that when ppp interface has prefix "ppp" in its name
>   then it is followed by unit id. Seems that existing ppp applications
>   which use "ppp<num>" naming expects this. But of course you do not
>   have to use this convention and rename interfaces as you want.

Really, with the netlink API, the interface name has to be set with
IFLA_IFNAME. There's no point in adding a new attribute just to have a
side effect on the device name.

> * Some of ppp ioctls use unit id. So you may want to use some specific
>   number for some network interface. So e.g. unit id 1 will be always
>   for /dev/ttyUSB1.

But what's the point of forcing unit id 1 for a particular interface?
One can easily get the assigned unit id with ioctl(PPPIOCGUNIT).

> > I didn't implement it on purpose when creating the
> > netlink interface, as I didn't have any use case.
> > 
> > On the other hand, adding the ppp unit in the netlink dump is probably
> > useful.
> 
> Yes, this could be really useful as currently if you ask netlink to
> create a new ppp interface you have to use ioctl to retrieve this unit
> id. But ppp currently does not provide netlink dump operation.
> 
> Also it could be useful for this "bug":
> https://lore.kernel.org/netdev/20210807132703.26303-1-pali@kernel.org/t/#u

This patch itself makes sense, but how is that related to unit id?

> And with unit id there also another issue:
> https://lore.kernel.org/netdev/20210807160050.17687-1-pali@kernel.org/t/#u

This patch shows why linking unit id and interface name are a bad idea.

Instead of adding more complexity with unit id, I'd prefer to have a
new netlink attribute that says "don't generate the interface name
based on the unit id". That's how the original implementation worked by
the way and I'm really sad I accepted to change it...

> But due to how it is used we probably have to deal with it how ppp unit
> id are defined and assigned...
> 

