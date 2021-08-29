Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C293FA838
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 04:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhH2CW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 22:22:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:41485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhH2CW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 22:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630203691;
        bh=V7qK4IrstNH3AProRHMWv7XjCfkBcbCbKQMNFd3lyWM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=htYWNyw0d/496zUttrIsOxeI9hqmbZfOeAHdyOAbACfCGHr+NOW6cHUt8XIb0Q3WY
         V58h8SbYG2zVrNhtAanmgmVobau/ETbuQosJdVyVQKqC4zJpCwe1tzOPpEFLXI6wI4
         GMSbWuEiHSWRiqSNSRYDmQHaZF/JERy9W89nUdag=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.207]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1mpuIQ44uq-00neVS; Sun, 29
 Aug 2021 04:21:31 +0200
Message-ID: <733f071797b9d358eae3f972f69c590ed81f638f.camel@gmx.de>
Subject: Re: dri, nouveau: BUG: KASAN: use-after-free in
 dma_fence_signal_timestamp_locked+0x399/0x430
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Date:   Sun, 29 Aug 2021 04:21:30 +0200
In-Reply-To: <b6faf6b447f2a5e92e50adb30bea8ebaa2e70ae1.camel@gmx.de>
References: <b6faf6b447f2a5e92e50adb30bea8ebaa2e70ae1.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fNcxUyiRZPevO/4lVvGn6WhhCmsG464bBfQP2rDimT3hUy/CDeS
 ebShOJgExsoQdkXo5uBevX+RiUwIx0kc9CP9gx1qR3+2+1GHEQmr1FKN9UgcdSZtasF7EkJ
 AJJ1X0yq7j0ad/vAGAnXNLkorefAs6A02Op4aKpy49FmDOGNleOCLc0wmye9MetjBPuzM98
 nDP8+GxMeDnU7qJvkYb7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lYfTE8v5jiY=:s1YkHLZy2oGK4EJ+uDa9Zx
 kWCi0c7Eo4xHsAWcY0gN2N1DRbQ8NgVoOXGz+NocQo1wlVGlqyqmDde614kuI3Aq625w1sv8d
 l1kuOc5FxZGRq3O/ho1lAKw9H6rOz4C+kD2k2spRouPMouuphCx7pBbm8ymhuPQWAPA1YLfk6
 8QI2BqdSAJ6lYek6p2MWKUvwybjDiPxfM9deaBXYZTw79f71EztN981Bzpojd1SPY8K7jQ2UF
 /GOC69W8HrpEKHqH9KYEnnYSbjnZLVIVfIcnCucQW+PlqIkbexbJLVldqsuN6EiGOFKNPs3v7
 GX12IrEH4Z6vmTANZLxeMURgy1Tndq42HcROHWLB4fJ+5KZp7dZC4O6+CGym2c6ULNWEMmvr8
 JTq/CcKn3TD8NxaB6vL3srAizq3EzHdpoQbq45KzD32/PEZYj85dUTVL/qnBShciaZ+lqwCRB
 L4aE6nkVH0wOr/attQQSCTgwm6yk3SnO87Ql5Knd++MBgxO+zntCM44j+zFtu738hVwJbMtAe
 KJIF+s8xqCZ+VMLIWIqkjha/DppDs00oN7s0smnTsvlIKYRqQvoODqPVuNM7x4PD16lCTO4fF
 AlQNm2Gooy5iGb219uCDxVG9h94DBVPWw/XmtJp5YdTdNaM5kKnuDG+4MYoi742KHa+5A2lrV
 aDvVS5KucRYJjvqRiG99cNugqegE85N5mbPosB5bSRCQ1W0yjK/5tLT+emP2h7xWNCY53LeOb
 EztrvHskRDrHw/vFuODVoJX5JawGP4wtI69iVMJB80BTPv2sovNWK4z4EdhYHJlTJCoZ2HpPL
 E5WZzoqH11t+MtZegt5hi73/kyfN4zi8agNzTjr1ZwXE5Kt9Xju+xP6GSOyEer/mfR3lQu9uI
 hZj4JO1RIszHg0+d1tE4zd5C386aJfMgM5g9Zd47vjk2fzzakuN2L/G8Ce/cKfAezXOvVOp97
 AXSixsquRlPO50GSvVZ6pQsOC9oGFvy9LBzpY38goj3K/XTpUH5V/BGLPU/Ui3bTo7sZwykwT
 05ongIOyhUD6ogKoCX27ANlmP0C5RnH73EsT9FR8swAdWMv/pqyTN0q6UMIcPlzb6BTFNW2gH
 15bxvwDqrYVe103dmBtyIWckLSEzRRepPBc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-08-28 at 11:38 +0200, Mike Galbraith wrote:
> Enabling kasan or kcsan in my GTX-980 equipped box will in fairly short
> order...

Correction: kasan does NOT reproduce on demand.  My bottom line remains
the same though, before enabling, either fix it, or evict it, lest it
take testing center stage ala "Hey, over here, me me fix me" :)

	-Mike
