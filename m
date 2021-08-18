Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9BF3F0050
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhHRJWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:22:47 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:40673 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhHRJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:21:52 -0400
X-Greylist: delayed 85105 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 05:21:51 EDT
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.155])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id CF9A3260EB;
        Wed, 18 Aug 2021 09:21:15 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 13EC32000C;
        Wed, 18 Aug 2021 09:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 282222A0C8;
        Wed, 18 Aug 2021 05:21:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1629278467;
        bh=Ka+Dx9RH3tuXhALIBTAbuUwAQQjOY5opWBs8RplNu6Q=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fRFzwqfKL/QnUD3HG75V2kWiP3Wou1s8qe0mPhroh9GDuLLzmm9qDpNbW60Yxmzfl
         XgU2brB8KxTt3dVehuIdJd/UucmTYkfbjPyvf+5M5skYtIZ2BCdMzWnf9i5C91ULI4
         xtyb+ID/Tn4+5HZuuo5MGv3LGRugZ/MmRknbjyO4=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jANVpBvcB0h7; Wed, 18 Aug 2021 05:21:02 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 18 Aug 2021 05:21:02 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 4FB5E40097;
        Wed, 18 Aug 2021 09:21:01 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="u1Fx14Fd";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [127.0.0.1] (unknown [112.96.109.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3092B42546;
        Wed, 18 Aug 2021 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1629278449; bh=Ka+Dx9RH3tuXhALIBTAbuUwAQQjOY5opWBs8RplNu6Q=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=u1Fx14FdhZgEpqL28ehYkFlf8onmFqDgZIh58GaRZ/ICHGz69S7pkPhz4l0Qo54BO
         INL54PxSrz/aHKcIbboa1G9m/aImXjttO/i9smdEkKViwtM2UNF/u9sDglKoiHRwu6
         boDpxFfr0xKsUIFLTfbAwuaqMK3ifNflP3af95jY=
Date:   Wed, 18 Aug 2021 17:20:41 +0800
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Kyle Tso <kyletso@google.com>, Guenter Roeck <linux@roeck-us.net>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGZ6i=1s9X58tOwoiGAxMkMVBTyGTjysOSe9bP8Q4WosmCtymw@mail.gmail.com>
References: <20210813043131.833006-1-icenowy@aosc.io> <YRuDG78N2mB5w37p@kuha.fi.intel.com> <58034df4-f18c-ab3e-1fcc-dc85fc35320f@roeck-us.net> <CAGZ6i=1s9X58tOwoiGAxMkMVBTyGTjysOSe9bP8Q4WosmCtymw@mail.gmail.com>
Message-ID: <949C620F-CA75-4A14-96DD-E42A349FC6EF@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4FB5E40097
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[112.96.109.179:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2021=E5=B9=B48=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=884=
:02:24, Kyle Tso <kyletso@google=2Ecom> =E5=86=99=E5=88=B0:
>On Tue, Aug 17, 2021 at 11:13 PM Guenter Roeck <linux@roeck-us=2Enet> wro=
te:
>>
>> On 8/17/21 2:36 AM, Heikki Krogerus wrote:
>> > On Fri, Aug 13, 2021 at 12:31:31PM +0800, Icenowy Zheng wrote:
>> >> Currently, TCPM code omits discover when swapping to gadget, and ass=
ume
>> >> that no altmodes are available when swapping from gadget=2E However,=
 we do
>> >> send discover when we get attached as gadget -- this leads to modes =
to be
>> >> discovered twice when attached as gadget and then swap to host=2E
>> >>
>> >> Always re-send discover when swapping DR, regardless of what change =
is
>> >> being made; and because of this, the assumption that no altmodes are
>> >> registered with gadget role is broken, and altmodes de-registeration=
 is
>> >> always needed now=2E
>> >>
>> >> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> >> ---
>> >>   drivers/usb/typec/tcpm/tcpm=2Ec | 9 ++++-----
>> >>   1 file changed, 4 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/drivers/usb/typec/tcpm/tcpm=2Ec b/drivers/usb/typec/tcp=
m/tcpm=2Ec
>> >> index b9bb63d749ec=2E=2Eab6d0d51ee1c 100644
>> >> --- a/drivers/usb/typec/tcpm/tcpm=2Ec
>> >> +++ b/drivers/usb/typec/tcpm/tcpm=2Ec
>> >> @@ -4495,15 +4495,14 @@ static void run_state_machine(struct tcpm_po=
rt *port)
>> >>              tcpm_set_state(port, ready_state(port), 0);
>> >>              break;
>> >>      case DR_SWAP_CHANGE_DR:
>> >> -            if (port->data_role =3D=3D TYPEC_HOST) {
>> >> -                    tcpm_unregister_altmodes(port);
>> >> +            tcpm_unregister_altmodes(port);
>> >> +            if (port->data_role =3D=3D TYPEC_HOST)
>> >>                      tcpm_set_roles(port, true, port->pwr_role,
>> >>                                     TYPEC_DEVICE);
>> >> -            } else {
>> >> +            else
>> >>                      tcpm_set_roles(port, true, port->pwr_role,
>> >>                                     TYPEC_HOST);
>> >> -                    port->send_discover =3D true;
>> >> -            }
>> >> +            port->send_discover =3D true;
>> >>              tcpm_ams_finish(port);
>> >>              tcpm_set_state(port, ready_state(port), 0);
>> >>              break;
>> >
>> > Why is it necessary to do discovery with data role swap in general?
>> >
>> > thanks,
>> >
>>
>> Additional question: There are two patches pending related to DR_SWAP
>> and discovery=2E Are they both needed, or do they both solve the same
>> problem ?
>>
>> Thanks,
>> Guenter
>
>Hi, I just noticed this patch=2E
>
>Part of this patch and part of my patch
>https://lore=2Ekernel=2Eorg/r/20210816075449=2E2236547-1-kyletso@google=
=2Ecom
>are to solve the same problem that Discover_Identity is not sent in a
>case where the port becomes UFP after DR_SWAP while in PD3=2E
>
>The difference (for the DR_SWAP part) is that my patch does not set
>the flag "send_discover" if the port becomes UFP after PD2 DR_SWAP=2E
>That is because in PD2 Spec, UFP is not allowed to be the SVDM
>Initiator=2E
>
>This patch indeed solves another problem where
>tcpm_unregister_altmodes should be called during PD3 DR_SWAP because
>the port partner may return mode data in the latest Discover_Mode=2E For
>the PD2 case, I don't think it needs to be called because PD2 DFP will
>always return NAK for Discover_Mode=2E However it is fine because it is
>safe to call tcpm_unregister_altmodes even if there is no mode data=2E
>
>In fact, when I was tracing the code I found another bug=2E PD2 UFP is
>not allowed to send Discover_Identity and Discover_Mode=2E I can send
>another patch to address this problem=2E

Well, to be honest, it's why I send this patch=2E

I didn't read PD spec before, so I assumed UFP is okay to send
discover, and this is what I got wrong=2E I should remove the
discover sending flag when we attach as sink=2E

Will it be okay for me to send this patch? It should help my device here=
=2E

>
>thanks,
>Kyle
