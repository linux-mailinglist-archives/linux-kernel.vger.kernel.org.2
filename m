Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E6736D5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhD1KrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:47:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:34325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236052AbhD1KrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619606784;
        bh=X1Ofs6y/nKKXN5JNIxFxJNXK+IWHmUmHEBq8oZ/31f4=;
        h=X-UI-Sender-Class:From:Subject:To:Date;
        b=UIpOf+x+cZA7Qt35UYbPTfAKrvM1QY8+54mZ7SmYvTgmxQeF4YRjfjvYTF59nrTDs
         vxU1KmGx+v05fD5zuKFbnxXyEMGR3eYYcgh1zVTtQu6LTsdpyZasqCdHeUs+5JxJZS
         8oFDnkulshOewubomK5S7QFalk/WNO6OHE1UZMEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from obelix.fritz.box ([46.142.10.255]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1m2xNN1Csf-00RnlZ for
 <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:46:24 +0200
From:   Ronald Warsow <rwarsow@gmx.de>
Subject: Re: New warnings with gcc-11
To:     linux-kernel@vger.kernel.org
Message-ID: <a49c2bbd-4c5e-f5da-c9d8-d983c3e36e41@gmx.de>
Date:   Wed, 28 Apr 2021 12:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NoGQHXAqCWaFn9P2L8lZOW7eTTMT71Ntyjaz1XE/UjAW9G6UN2C
 l/gpnOPvuYpz2Yb0L0SNsrQZugFRh9eGbTU9lvJoiHv2eu5Tseq9TTIWl/gcSsk+Qj2NUkd
 jY8tsSlgp5VCYs1LsXQ25KrHh+UApgn8K2mQfQB0nz6VPjpEvTM/+ganCv14c0J7qF2HZcq
 Uef8Ypu6w6lj6PS7u8mlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0LS0aY+PUwY=:nBZ6YIIHaEp43nYW/GlmJa
 XhOpOdv9ZA+xEuIXpDw9flW+gJhqdcE+WXRbzc6ezyPyuG8HZBK13rlJhWmltEZfhu+HLyHbj
 p+cEgc6ywSnuuwhDtUa/2qCjwt4WOHPxlYA3jEUTABUt01ojeE+EmatkLCqaxTIgovzqidxkT
 VCsZkWGV5Po8ksO3/PPy0KUn8m2eLU3QBKLnU1tkJ1RruLoem8RGvhX4v7DQxE7x+iN+NDxpS
 fxwUvgOeYmYXqKUbeXXWs5So8jB/eIrLiOMsmu0Dm9XLXQP3jSqR7Yxo1LBs/8VNd0Wy0Uoju
 HszSYs/nw7cJd+rveTBzm6dkedhfxV+a3xLy5pc2eYWAAcsuQ3G4Xlr54/5zCbNH40brbCqLI
 j2tyyjdL52X7WjK0nic1VSlhzIZj5VWbaDEJEMfi6CCYIRNe14+h4aPE4M8gtxkLFFoMBcBLI
 aj7pk/GlWXEegNqOh4nQkPRHfj5L9+onbKYNAN6HS+vK9VoXzCCsIqIE33PhxANUjiHOQQbbR
 GuRqgWDPwA7spqoFYRErKN7UCUr1CydeG3ySolQq/6E4NUuT1/HyDsZslIqmgzRm2xr4Rcd9o
 yywmmD78IT2xK27Z0Qd4jLSmkDcxeiD+XCDuOflk2H/fkSYpzbXEqTr2S2ODWaEGx5dnp3bfd
 SacxqkHmNlNBp/XfGzRqGY+GRrTL7RHMHcpbc9zwiRVgJIgBa1ah+u42zEsUz8Pn5CeoTb8pr
 64Tb0Au64Br81rmrHoMR7BjlNQVFE7pJx6aaTuhHNEXvKi3f54RxEEM24b7I2fPLY3dFz9Aa9
 QRfpzGtwgxG48Zsrnx/YKLEejUYzrZGgx3kYWQIWLLLNgUCCKCddHcvWSn5+384tTVpRyTF1F
 Gu93tBh37qR1U6QH0kKQUtOMGHlMjjPxt/tizk557NfqzVRrL3w4xBKLmsFmNOphAcXLmwXWN
 WUnxna55yN+3wVpvk+UxlDhxf5jbrm+jiG3sgwlXaCpCnCGoyx7cl8ME3Oa6nEY/Pj3NR1ZwK
 GUgWJEoShDYTR3kC1HxnTKgyA3c93HBoy/DEGAt5sCvknsAACPHzrLNtNH+U3DPyLDtSipSd/
 j7se3zMIRitXWWJ2lJMNTqIGX8dE3WXu8mQkLR1K7cC2DwKFM7sZjWAI3M4aT6TpICAcIqI8y
 RZhfb0THsrCuBfKuCvLSmysaNMEW/M+VqfN3+OnXxiI9l9V8SeavvWqs2a6bg5ZLNnccA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

may I add this ?

https://marc.info/?l=3Dlinux-kernel&m=3D161819303505220&w=3D2

=2D-
regards

Ronald
