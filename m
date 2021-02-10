Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE031641B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBJKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:44:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:36077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhBJKmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612953631;
        bh=paESHhGdxaMJReEYpSaz/aynwepipVdSG6B9lmgKyrg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=I9KbajfrMoUVLYyPkZaHPF1HiKjFo2nXK7dNfbnATbXLSqCeO2fJXO2ZD95CPRskd
         OH5iEkGiou2y8Gt8nThHWRxSrTxHdjcQhZ1hzsDFzjyFQ2dchIjBRtlGMRTrSz+Tux
         yZXAaQyZeLqn9+4JooYVhNri96521wS6O6KTtXUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.231]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fjb-1lES9B43fz-006Nsa; Wed, 10
 Feb 2021 11:40:31 +0100
Message-ID: <9d221e6160813fd188de26d3b56443129e9f8003.camel@gmx.de>
Subject: Re: drm/nouneau: 5.11 cycle regression bisected to 461619f5c324
 "drm/nouveau: switch to new allocator"
From:   Mike Galbraith <efault@gmx.de>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Date:   Wed, 10 Feb 2021 11:40:30 +0100
In-Reply-To: <43924195-c4e1-fce4-5766-aaefe2d6f766@amd.com>
References: <1d663cd74af91e23f4f24ebbdd65ef3ba72c15fc.camel@gmx.de>
         <43924195-c4e1-fce4-5766-aaefe2d6f766@amd.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l+VEAe66+pl3U3UrZ14BhCYiNOYg1SQgtKRrwYe5Wz02JMOEoaU
 EYnAGsn/WpHlCTmHGk9gINOHBSIQIUkowYVB8BnxCa29wQ3iiW96qm1YpQIIKsPCsF7ivSq
 0iy+ABDl3EwDy+rcHFHlq46XaQ4RWTdan7+vPRDxUEWPNG/k2PrZ9DYB3aVEYPqyy9rdR0x
 NybQ9Kj5RIJYyoBSBMaSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j8msvpD+YBg=:x6fHJGdCzzHr7vd/R+m4Ar
 BpLr/tFQBotVoFsdUsKejfZE8JZTxV6b36Go2bcIxhDbj3D480uIlwyjNd1R8VhmpFR7kXpW0
 JpeqjrJaL06TNaUiSsQ67QV3j+gBZCKfPHcTpZueQN84SRzNSN+fMyv8cWjHQu6Ol6TAiW4JI
 QqvLMUjw47BJ5iHwX9/S8MO7XKV0S8VQhpf7Yf3sQLj5g38ikrrsvPj6BvEKiWOLLLq/6K3CI
 NQmJSuF1o9uK+8nrBuGP7VUj/1RK7telbpyDVZ87RJ1zdesMC1SHXrCeIcn8pbR0fdcWIm0/Q
 YzpRgmBgF0eVHu6wALswDgnBlKNe8QH7TBaAn8iLSz8OljV3Z4BCHI+3IfWqSQS5OmDdbvDZ+
 hd/IJl9d2WOyANpIhHgONI1zaG7Vc/E6ujADV85ecnJ+4tX7YYCDmKheI9bMeKEplOk+5pcax
 eBEy1wfZ7VYlR0RbMx3B3jRfvDLK3xTKYLsW/4t1EE5ouPv3VeDpAiI8kiuosNJ3N/Ml9Vbca
 qWiDeOEOVkK35Mma5bdDeAf03uQKpBk0yRTXd3Pdtt8vTPYO0aQNgFhdy91Nh25VX9ID6dYB8
 gVxV7fIuj1hBoT54VEH9IdiJOHKekwIBJoy+S9hqS5O7ucuWjmMxEUeIaDLMGnJNH8eS5aJQx
 cnUiuET2/2a6N8jt16TlbnudSnS4cFMPEenHOORE3gAuDn4c/6sfv5XKr2A6ChDIXXKDDVc8M
 q/xramWsYpTljSmx/fAd9wQGQ4OzRJeK3cL1SHoWdCt3QbgViU9ybk+ispI2AenLwAk3rQB9H
 RXEhqM7sO02d41EjSIGnOJh6lCpxtiX5jBQrLbezFPodyNgzsWuFqOKrgXDK9jv0sd91EOo3I
 z5Tqjzm4/Ll7uwl+NORA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-10 at 11:34 +0100, Christian K=F6nig wrote:
> Hi Mike,
>
> do you have more information than just system stuck in a loop?

No, strace shows no syscalls but sched_yield().

	-Mike

