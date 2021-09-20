Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF9C412916
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 00:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhITWzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 18:55:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:34429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235318AbhITWxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 18:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632178309;
        bh=pNgQbIvuFho6eNbxETi+pJ3R3lPII/44xyArN3GF1Mw=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Hw4ZvIyFWrW6EoG38M8acMlkqvLW7UOEocIhIyFt2F7/nC1qaZFbywjW2n3c9Peya
         v+J8H1G0Tkgd3KeEnUdqZFLbnmXOfPDIBArJgM5+ipiZ6NOi6WU+9rm7WllYkkkiXD
         K3rsGnO15pOlfHOkzjOu/P4v/13Jpw1XD0BQOk8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hos.fritz.box ([91.48.115.95]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1mcfYI1R7H-00AojA for
 <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:51:49 +0200
Received: from afrie by hos.fritz.box with local (Exim 4.92)
        (envelope-from <afrie@gmx.net>)
        id 1mSS8a-0005wU-Um
        for linux-kernel@vger.kernel.org; Tue, 21 Sep 2021 00:51:48 +0200
Date:   Tue, 21 Sep 2021 00:51:48 +0200
From:   Andreas Friedrich <afrie@gmx.net>
To:     linux-kernel@vger.kernel.org
Subject: REGRESSION with 5.14: Resume not working on Toshiba notebook
Message-ID: <20210920225148.GA22791@hos.afrie.home.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:UAGWPTtGet2g6tl96/1J+WMSzcdRTLR9YiHh7tAo0I8ym+iklyM
 vr7Jzwgzdqap+wJfCXk4RzMlf9liRvPYE16JrWu2tf/wIRhG3Fd2e+//J/Wc5sc0/s5pFtc
 B+XJMy0g9HMSqRZQQgnSO4RMqzBosP0e0PJQhMZtUnPYu+XaAmq/qoFqfJf2kj26jwdAFhJ
 aN3cnofg4AuVxrRsD2gqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wF/l22+pf0E=:JyMFDI1cAdfSyt4Ay+Hjkf
 Wun1JtdbAhMMcTb9sdTwGCKBlKJKlEbjFB5iF9b1yIPjFEL1OOuv3w+AvljtBL83V2zRhAxBF
 YCXewu/nGSv2Z64w9sJsLgyL7JuADN04j/ZfmywVvZold5jN9QORDL0iyVTC7aiuJb0L0CdN0
 wQsW7mLPPkmQnhCiveQ5qxQgy1lysJlorXiyJgCDYQt+P0THiQO/WDO9Kxgy1ZCJxIB/dkPej
 dcISRt1OJbnTIHZ2jL0NkicYpcRE13dFQNAGzXZrvbok8ZTB7zWsqLLU9wEnfbieju+mIUuHO
 p5wMetfto+S42lBPIoUq6B7fdf2UU5wX6Q3r98WxFh3w4VSnlQgRxQB7kuLIm4VrOkaufjWQH
 1JZuHZggDsBi/cveY+ICYxSHGxzNVktomYVHeY3rFK8L8v5Wkr9Yb1i9a4Q37JpTRHgEg0Ul3
 w6y+HwvbaU/iJ3bkh71vmnUvaufbJ69nw4leZJb7DWJsUPzBbJLIkXozBJMjO1d0eGqv4NH8V
 Hnqqxb9PLZiHJseb+k5y/o4TjlcJ27I9vdBV1xfP++X3dOgslfDqC60jkTY/QnOFTaz5WM6SF
 8sWAqByyvcxLxapKYaVwZou0sbaLhB2YIEcx9k39BwinV1BFTXnTscu8rk3QGjpqvP8c0vf8I
 DOQdY6ZYTqg27MU5lDa8vnmnbymGMPP6IIkm5hSqN9kvJeMVvMYoY792E39kjGIYALKWhuTrt
 YkeDr5FzfbSY3Jt8DHDlD/5hXl+Cy6+lqfNr+SaKwMOJ63IQYPi+r4ASvBu+1HUzupKHJnKNt
 dMNonCtrmSGkVqscEE6ClLHRmkGDDuhTxgCxSb8murUhi5tDeULgSEmAPsO1A7rDyujQkNjuq
 4kxN8/7+1o8HP3BK6Ii7/2z5GRetfz8w1XNpLlzavNsQGXqeKOPNYCugHe8/griI3/5a7dABj
 erP6F63OsN4OfPlQ5TFH9xKTnlvUXtigxQa5OCrlljogYpUBPeOOJ0uMBzeIgcttFUPFoJcCu
 0iXciCAKSuCKQsrHhR29/yjVGVPuzvuJb5V84PxCJRI0QidSThZ3UxowT1vWzNxF3DUrn9vev
 EQPMSvPvTfKSb0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on my old Toshiba notebook the system crashes on wakeup (resume) after
suspend to memory (echo mem > /sys/power/state). The system is
inaccessible from remote. The only way to get it working again is to
hard power off and on.

Kernel 5.13.13 works fine, 5.14 does not. When disabling DRM_I915 in
the kernel configuration, 5.14 works fine too, so I have posted this
error with all further infos on

https://gitlab.freedesktop.org/drm/intel/-/issues/4049

Until now I got no response. Any help would be appreciated.

Regards
Andreas Friedrich
