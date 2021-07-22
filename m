Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28F3D21D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhGVJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:30:16 -0400
Received: from mout.web.de ([212.227.17.12]:38425 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231637AbhGVJaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1626948648;
        bh=AvlCrQmD9OJ1+lL/BRCB+v4cOg68WKsJxnLX8LWc23U=;
        h=X-UI-Sender-Class:To:Subject:From:Date;
        b=f0hlxX5RcwnUdx8u02R2IX4Ogj2ge2mIZZyns8o26treLwIDtS2ri/VP28IFnNIES
         bDYkSDmPpH36//F/4elMQwAKcplNw5V5SugvQJ7c6lDe1cXShGS4Q9gZabyLYAQItP
         XIA0IEWpC26BrfDF/42SKjhZt74ftgBgAgAZtYTg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([178.9.212.178]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MfHsM-1liowk1wIU-00OsSK for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021
 12:10:48 +0200
To:     linux-kernel@vger.kernel.org
Subject: Kernel 5.4.134
From:   secret <andreas-stoewing@web.de>
Date:   Thu, 22 Jul 2021 12:10:47 +0000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <202107221210.50398.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:hHBnTF2yPG6RpDNkZKde84EvHpiQTFCfAlJ79BdklKdUKcTKCiI
 V6fjm9mjdr2WCQlZyqwkzJEqwKENS8ftJ5b64iHMl7wsPXSsW0ZUTf5mH6yaawoL0oX99Ju
 GEq6K3/MWxsQU5oGM6SlFFDLpETWRxD5KVHavNGyzvhIPYOrsz357XaorCl2EqjtF1pRemr
 tXr9gkv/MRnzt40BRTNnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2hkzP03sBHk=:nN5BuAxarE/GR5507Sm/wV
 qZgw9tla9RPBvcgFYZ1J8+c8RJoySsiyAjITUXv7HR6AlHbLGGCzgqW3rhWGA4+anm31Q+d1Y
 jlV7j9USzgsogc8G/dAu0JFMIvFW6ReGAX+TMGfCajQNzgMFREAwVOqppH5SmOH7WxDFvA/DT
 jmgERFHdlUby00EwMnwemfH6gO+uH62+dSQJsU4Xd9uJF6Pm1h66i4giDQd5/QZLMuvY3Y1UW
 brn/syzpYO/Pa660IxJKLdj0w0VtV5zhEBeCn5OAe1LVrDjN/xQ7oKA8KkBUwM6Tl3KoX0jYD
 DR9HcxaImE6feA54sOrQCfkrXV9Wne8YocYV0E/Dlv5OGcFbk+u7n2BFBbbw+Hrk4EiEGeEUz
 HQnYHL4WRPqDCDVb9ViDWL75asYqexvUpyTwABDL/UjotQ8KPCgzv/n380U9JRVUKhJMB8kEc
 bVuPQWtOAY9HwJ1aTchBmXI5gJ2Tz820qpIo9vZ02uOf5e3vZT/ksWP7jbjBorvM8uz/GBPD9
 iaC60VFjE3Zjyb3K/7H6WplG2275kxzsYydp0rG7qx12zs3gMaHINZtyoduh28gfk0EK+lNpn
 ojFgQar1LGJqRcqkDh+WXhreElnZCdjhJAL8+blh4TRHERjpgRVwHrlrOrIsqC8fm2/GkJchu
 25tNF0z96tG3Ut77OGDiu5ifsur7nn3oT5rblFuWjnO/ot2iTWsRHjIevfBqd24MYk2yuwBNA
 9yvCtoUfxN9KVBOMtNYYR/7108NgUGxBgYY6CDicSlShnhA9kcqeDL5JjBB70Sk6WPu/JLP8J
 G10P7fs0RozRn1nVIYIHKSPDSnNJ5tVFYVjYp2gvR4xzC2eXbEaE9x2nQ4xfx1qxqxiRzczP8
 5EIhXES+dv4xmR1Z9XaFt3hYz4bv9WG8KjiAM6Z4GQWSXuk4q5oTTAN4ozQmfabo3ZE9qlNX/
 BELRz2wYNFZcbCTYUQ8qkg79mTBNLb41JG6gytFuj7KGP8CMb/dwOWw/KpnqRR+J+joZ1WoMt
 402z6TDSQgiJ5R3SPksb4/FH/HzA/v/9KNbEqcl+icJxpEKX8CW2hVNgKPIJmedoHXpMV+KhG
 tDa9FKJJ+h1lqinFi3QkfagamxRuYV6T6SXUixmHls005aEwLl3Iu6i4w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I write again the content of my last E-mail to you, for  my smartphone has=
 got
only a small display and therefore a quit tiny keyboard...

Whenever Tor from rosa2016.1 (Rosalabs.ru) and/or Enterprise Linux 6 is
starting, at least three kernel-processes start too and/or become more tha=
n
active (CPU capacity lies by more than 10 percent, making my orange LED on=
 the
tower blinking a lot)!

So they have got root-rights!

Their name is like kworker-kcryptd/..., dmcrypt/... and uksmd, but this is=
 not
their complete name.

I do not want this activity as they irritate a lot in possibly causing hig=
h
and highest risks!

Tests have shown, that no data seems to get transferred over the net, but
knows the hell, what's really going on here....

Is it worth a patch for you,
can you resp. your foundation patch it?

I would appreciate this.

Regards, Andreas

I also like to tell you, that this Tor is surrounded by firejail from pclo=
s,
this is PCLinuxOS 2021. The processes get permanently highly active for ab=
out
five (5) minutes. The LED on the tower for read and write on storage media=
 is
really blinking madly hard all this time, while the process-manager confir=
ms
the whole mysterious process-activities!
After this time, Tor and surfing in the internet with the browser do work =
fine
as much as the rest of the Linux. So I have to wait several minutes.
Does it have to do with one of the last patches of 5.4, for example the on=
e
for dmcrypt? Anyhow I use full system encryption by LUKS, that might matte
here.

Regards,
Andreas St=C3=B6wing
(Gooken)
https://gooken.safe-ws.de/gooken
