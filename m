Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5010E457FBB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 18:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhKTRGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 12:06:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:37947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhKTRGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 12:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637427803;
        bh=FvLtXViYCFF6joVrwb7GrrUgr6TUM2iKs9tppUNqS2w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MyaWGYbMtoBsDc2+uZoA+tedmnZNaWM9RdggJDThmPjiLHMQMFYmywgRhWEqL66yn
         JN+31S4ZWAE+YlXH9uLs+GJ6gpBgdfCQJdMTimJmo0tjXX5bfyDi9NXUlaMPapweJ8
         FfgFOZaMnD7FM8dSIDUUqqA7p1YdcoQ0Tacygd08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MAfUe-1mv2Hr0x56-00B5OW; Sat, 20 Nov 2021 18:03:23 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (dell-smm) Improve ioctl handler
Date:   Sat, 20 Nov 2021 18:03:17 +0100
Message-Id: <20211120170319.72369-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IfRzUzngu5f9VFP63qNfHakXbRp88z4u5jsHdSes7eht9586vNn
 DyIpinEwOriEBw6sUKL5HUGiKJEw4ae2oJkKi8fnAnDD5hQv1l3/6eAIbstAutxw+8V0SIV
 2O2+LSjLwrYAT7VpUixIm2w8GnI2drGjybXLAOUEZe77eTDL9htpulyvi8TL1QfRgdV7cLz
 2FUMrZOW7dy7j8h4E9hJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tDOeJEY/3yY=:igTVYyUAF/TEOXRf3L1Lt/
 423CGHA0MPWjwcD4Cw16C0y/6rBUc6j5lY8jFn4dWXsOxyREnLlf9+5lasHyhsKf1c6oHk3bD
 v06PFFMTDwTSfJSS4ZHzXibRi2J5sVgaT7f3/V1G3TnWu3VkAlIfy19UtN4wqt9lhXYWdxT94
 Qi6UK2DYs1P3o7nkuboOwPHUeXpiNHfAK/lAOsL4tEiNtWxxoTpfomgnTNrPmr+t+RBlQxyUP
 T0S5a8PCCx+6mCk7vt8s91170DSewsQqPgQu2vc3yguEE7SxlMshbuX2GymXqlVPyeyuKh3LG
 0Wo6qg4A9gyuqy+1uuUjMK5nA75RfSyjfnK5deALbikox8QEjJZj4JET3PCPmwOHe9XipRKbQ
 BtBVyOHQ8GzvoAKyvjWz/b5g2oT4icSdzsL0wvc2uT3mYtH3aYTIIg7QDDGYHdXY3qutHHVsl
 n/qa+ggzs+en5db0Zs5/CetOMSMPmMSJBeU0FFJKkMVY/X6RaT5O+2NmADSSsWaxRNtchEEeQ
 8nok3zJC9Q47rUTUH1uGA59WGTkthcI28s1GnDqqQlMqcta2zNdzLxjIuS3EHGQucrkQba/Cu
 2D8BTTb5RxTWHwtQ3B1jSFl7hCyYyTEncVPCOJMGAOiZFNJcHaewHiu8y9mGJinWm4c1Sp2m4
 fdNAhR6xGbKhmJXXLaDS7gsjW8kvdqj1SF3HkZ6LTotl8MGP914yJCUUviV+hcPaP8V9LpPvn
 j+6eUpJzMAVPZQ8JLILlrB77fDweZEO0y2izsShtzSA5ublvZUKpjNqyXmvTFZrjdjim57EoG
 7pDuySUAT0lXW4yqAPINXWnCqY7cals/MZ4aLklGobjY4b5pySVU/HyVtWRONDXnzOJVu5p+o
 JVVElzh3URNfRXJCpcdYwk/okMmlEz1TbGoATcXGjxhofNJwHICMW2hV4dGaOameOmyrrQtk1
 ItoTmqnGL41Rgr2lqPRkNsobDpu6V4HzDv+Dt/13/OuOlP9jGa0p4C8gYvyhMzhQzEzM+zrYA
 vLMf8mLTXwypeZ4rI/VuJECjdYXKFr7umNLuYc2aEzgsl67X0ios5NPOVNbVlJDcctgF1a5gO
 E9M8bUNxWVusa0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the ioctl handler in dell_smm_hwmon.
The first patch is simplifying the ioctl handler by removing
an unnecessary switch case, while the second patch is unifying
both i8k_ioctl() and i8k_ioctl_unlocked(), resulting in better
performance since i8k_mutex is only acquired when needed
(during fan status change) instead of being acquired for
every ioctl call.

Tested on a Dell Inspiron 3505.

Armin Wolf (2):
  hwmon: (dell-smm) Simplify ioctl handler
  hwmon: (dell-smm) Unify i8k_ioctl() and i8k_ioctl_unlocked()

 drivers/hwmon/dell-smm-hwmon.c | 57 +++++++++++-----------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

=2D-
2.30.2

