Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD236FC95
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhD3OjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:39:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:45179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232648AbhD3OjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619793490;
        bh=cfsGfW8WX6Q1unP1IHR/X/PhgVV2sUsIKvQxdQwtyX8=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=HQBZa5+tUjuIgooJ+8YW9EtivqwxdfhwbqCCSivrEjZabG6lpJmTgXY/osn8xnpGj
         B2WwOXvpCk8W0PtgM1ZIgPcohTw96nIOrZq2tbtemuMZpsHLBmvcJSlJVcfAXo1tIH
         P8xyePnpsgPA+b16YXRLT1Je08VsmtuC0/QDcTTw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([157.180.225.50]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1m4cii1Zb4-00Yf3b; Fri, 30
 Apr 2021 16:38:10 +0200
Date:   Fri, 30 Apr 2021 16:38:03 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <YIwMvUVmeeYT1aph@kroah.com>
References: <20210430124317.97376-1-linux@fw-web.de> <YIv969BCnPgXzrcg@kroah.com> <trinity-5166e76d-779d-4b05-870b-59971bd1571c-1619789439850@3c-app-gmx-bap03> <YIwMvUVmeeYT1aph@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Re: [PATCH] musb: mediatek: rename driver
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Frank Wunderlich <linux@fw-web.de>, Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Miller <davem@davemloft.net>,
        DENG Qingfang <dqfext@gmail.com>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <16ABF577-4EE1-4BB3-A801-A4498CBFCFCE@public-files.de>
X-Provags-ID: V03:K1:nNdIy1J9VWHYvq27v3HRerK9WoB1HhAi5teVaPMzkMUr3nXD7bw
 pLyTYd5blwokALBrPe2HaQ7qyIQDPU6ZAkLsx1Aie3HaNoc4Hj9fEfliiMEsWbMugL67aYH
 BgHlUUjb3G0FN4+M6pcpL7MgSBDQA/v0afJbv+ILs3IIIZ/VI8VN2EacMLplH9P7UwAbcAI
 bTRqWJdcqP2SKCfY8EwmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4C+fKdX9Ows=:f28tvbwSYFV+fvbGFRkpaN
 UcyTVD3rW+h008YUpiLGiH2EIXpWYvuzGk2ewQNCo6BrlCaAndNP/m65wU4CjB5KHBtdjhcpz
 RKXouVpBnjLl4yZOXQ/OglmcWLNINJj/EsOYa40ZqRS7+cHTehqRX3MgoxVyFWajPIwROQJCj
 8+pNr9JkLP9+x5Mn8VZOmTrUWZGLbldTF+i+yx6Wlm44XU5H3A3HSBoHGHXwKW/wGfslzaYnJ
 95jRi69e8lN6swEz7TK5nH15JdGmRDjrRvgXH+ZI9NBAiQnwHUOTEJxm87b6POM7vqaRHXITf
 5w1YI8jKLhj3jC7ITCcDjNl7SCSt/rppLNIVCnVtYmsbpObhqaypxportYBHw2120GcAqBZ/v
 ZUCGQJsKhkjvhW2lIJQnKtJo/wCdb2jOdHylq9AAeH3anke6YSbGnTGqyLGO2nKG4tBSHk3xN
 ZA1s9Fvgr5eW0Ixd34FQy1eXGUSX5VlBGfTZTKBpZe52hCQT5o+Zx/Td1caY5tTsn8f/ovm0e
 yvIGKPW7Y6/myarxtuhwcZln6zQ21uEvhjaHNzDY4TbFZ6E8NfWRWccw3HXijTpmfsKVsbFl0
 vjq+6d0oAPxFDzPevnuqAbdK+qRcs9ndNZ28FNc3NzXNRbtdfLgv08/DRhi/SrExKfk9MpU7S
 BEAWZihazoZf4MdMeRwjhCDPH/Mj2U5RHex6BuuIjg19kEo5zG6pY9uQDJ7i+94f2+T/s5Dct
 VIp1HW+UfY6tAb98biT3gQ6qZRa2W/DUZyD602/nRUJ0VS2B6zVDVUitwYa8XDUhH/VQClxYV
 fTZqYOywuMI0j+SupcpVyVMMy0Ox9oaWhCTQiOB2VCYjm1tFdHO8CxDESEvGgS9jkp782bccx
 vPUhZ13I1DVeeL3bv7lKaCaLkZDCZVkDQezbZcKPw58Tw6XpdGmvCdCRt93PGjG48Sr5G0Ok3
 vy1EPowUdY5qeuZJ5q9QBk8Z2NGx9rRjX46pECyNH0ZZm1EhUOmatHfApNsbjcVb7pA9mE5NN
 7SvkUXBwCASnlwA2RRfoRUh9E2V/4DK1+t2ek0oceIFUU14Ezy058YCJchTRMdw671my8MSwU
 NrxP2hDuRhd5VZfFhi/YvTzFqht39Tx75b2K0GChvboHclQxhd/rZ+dLd6A002zsi8tIF6kZr
 qGDF62Tu0nRe5PqrrBl0ozuTthkhxDs3vNGJjW7nW6vaQiVNoUs5pkgpb/dPewFBQ2ED/g4qM
 pw7vU6a1sjlNOp2ki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30=2E April 2021 15:57:17 MESZ schrieb Greg Kroah-Hartman <gregkh@linuxf=
oundation=2Eorg>:

>Why not just have any new driver not use this name, as it is, it's not
>hurting anything=2E

I just want to make it clean for users/admins for what kind of device this=
 module is for (vendor=2Eko is imho not good at least for vendors manufactu=
ring such different devices)=2E
And avoid such conflicts like the phy (which had reintroduced the unclear =
module name)=2E
The new module will be renamed in next version=2E=2Ethere is only discussi=
on about the new name=2E=2E=2Eand so i tried to fix the "other end"=2E

>Until you can guarantee that renaming this is not
>going to break anything, I can not take it=2E

If a user/administrator installs a new major kernel version he needs to ch=
eck if all is still working=2E Then the new module can be loaded=2E=2E=2Ei =
don't see a real breakage or much work for "fix" this,but it's ok if you do=
 not take it up=2E

This driver is afair available since 5=2E4 so i guess not much spreading i=
n large productive environments mostly still using 4=2E14 or 4=2E4

I can repost with better description,but this is not needed if change itse=
lf will be rejected=2E So maybe anyone else can comment too=2E

regards Frank
