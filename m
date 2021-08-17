Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD743EEA25
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhHQJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:43:28 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:39173 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhHQJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:43:26 -0400
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 7AD0D260EB;
        Tue, 17 Aug 2021 09:42:52 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id DD9D53F1CC;
        Tue, 17 Aug 2021 11:42:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id BA31C2A915;
        Tue, 17 Aug 2021 11:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1629193369;
        bh=FkrJaXbezoWlUIzlLXe6PbAJUPxZx/ZrdnrQAm77CcY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fYalB656gDqDvxzShA8MbsCYDorxNkzWFTuunu5/dTIzs3DFYgH2G01ZB2fZw5n7J
         kzTVBSQ0UWb8JJhVlnDwO15/TLUylCEUlGidyu+s2b1tT9T7A5u8SmziOLOf1pMFK/
         D62pimbqOyvEcL2s8DacxUuBQPvlpUCA7Qtgi+Vk=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EAh1KGjLN-C1; Tue, 17 Aug 2021 11:42:45 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Tue, 17 Aug 2021 11:42:45 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 7166041737;
        Tue, 17 Aug 2021 09:42:44 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="jEImuBS/";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [127.0.0.1] (unknown [59.41.161.211])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id DA0F240CCF;
        Tue, 17 Aug 2021 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1629193348; bh=FkrJaXbezoWlUIzlLXe6PbAJUPxZx/ZrdnrQAm77CcY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=jEImuBS/pbTiB0xTTqHAm22XRPP309CyeMEpkBfGDdYmK7b3MY//C2Up5gVDbcU3T
         BxrfxQy5DJ3wlDwSk4gcKX44N2gb+FuaajjyJKAo0rJUGVeQlWPEnP9ffuyr2y0VUY
         VfMeVA96KISIIFEGUa8W1FvLEhPKbC+dCNec+pYc=
Date:   Tue, 17 Aug 2021 17:41:58 +0800
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
User-Agent: K-9 Mail for Android
In-Reply-To: <YRuDG78N2mB5w37p@kuha.fi.intel.com>
References: <20210813043131.833006-1-icenowy@aosc.io> <YRuDG78N2mB5w37p@kuha.fi.intel.com>
Message-ID: <E91C97D0-7DB9-4455-AED2-4C25B7D2D22D@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.211:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         RCPT_COUNT_FIVE(0.00)[5];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Queue-Id: 7166041737
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2021=E5=B9=B48=E6=9C=8817=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885=
:36:27, Heikki Krogerus <heikki=2Ekrogerus@linux=2Eintel=2Ecom> =E5=86=99=
=E5=88=B0:
>On Fri, Aug 13, 2021 at 12:31:31PM +0800, Icenowy Zheng wrote:
>> Currently, TCPM code omits discover when swapping to gadget, and assume
>> that no altmodes are available when swapping from gadget=2E However, we=
 do
>> send discover when we get attached as gadget -- this leads to modes to =
be
>> discovered twice when attached as gadget and then swap to host=2E
>>=20
>> Always re-send discover when swapping DR, regardless of what change is
>> being made; and because of this, the assumption that no altmodes are
>> registered with gadget role is broken, and altmodes de-registeration is
>> always needed now=2E
>>=20
>> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> ---
>>  drivers/usb/typec/tcpm/tcpm=2Ec | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/usb/typec/tcpm/tcpm=2Ec b/drivers/usb/typec/tcpm/t=
cpm=2Ec
>> index b9bb63d749ec=2E=2Eab6d0d51ee1c 100644
>> --- a/drivers/usb/typec/tcpm/tcpm=2Ec
>> +++ b/drivers/usb/typec/tcpm/tcpm=2Ec
>> @@ -4495,15 +4495,14 @@ static void run_state_machine(struct tcpm_port =
*port)
>>  		tcpm_set_state(port, ready_state(port), 0);
>>  		break;
>>  	case DR_SWAP_CHANGE_DR:
>> -		if (port->data_role =3D=3D TYPEC_HOST) {
>> -			tcpm_unregister_altmodes(port);
>> +		tcpm_unregister_altmodes(port);
>> +		if (port->data_role =3D=3D TYPEC_HOST)
>>  			tcpm_set_roles(port, true, port->pwr_role,
>>  				       TYPEC_DEVICE);
>> -		} else {
>> +		else
>>  			tcpm_set_roles(port, true, port->pwr_role,
>>  				       TYPEC_HOST);
>> -			port->send_discover =3D true;
>> -		}
>> +		port->send_discover =3D true;
>>  		tcpm_ams_finish(port);
>>  		tcpm_set_state(port, ready_state(port), 0);
>>  		break;
>
>Why is it necessary to do discovery with data role swap in general?

I think it could be possible for devices to expose different altmode
with different role=2E

>
>thanks,
>
