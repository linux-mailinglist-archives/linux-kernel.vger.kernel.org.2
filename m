Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378D239C6B2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFEICL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 04:02:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:47563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhFEICK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 04:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622880021;
        bh=jXkO+/WzWUdDgrD2llurrG6X4RBpdTGXMAUhcKfECc0=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=Tr2NutvaI3Xq5mmJhsFnzORSkQBsswVkng6JkOWMfWzFTFNqCOV29tgBYMDFOP4Q+
         AY6T4zSsAZwigZNzF2t+Z2u5tQaBoRsCJzKCEZ6kK1j+xEgznHTfRqk4UqpymDti7n
         WIAzgOHCThDsZYGhp0oMLv+hBgrbpTT6SdNiy4aI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.8.88.99]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1lBRZf0OLS-00ePs7 for
 <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 10:00:21 +0200
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: FAT_DEFAULT_CODEPAGE and FAT_DEFAULT_IOCHARSET should auto-select
 NLS_CODEPAGE_437 and NLS_ISO8859_1 respectively
Message-ID: <6b15c8a9-ff00-5a9b-57fb-974028ec4de6@gmx.de>
Date:   Sat, 5 Jun 2021 10:00:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YnnrB2BBi4yYlDa0S5kL+4FV9Wf/mi2VouYYQ564Zb3KXDknY96
 M/2yy8erIW7LM7dg/V5bt/uIYVichC0ATJB4HKehUvB7O/loiMWZ2FUcZjp1xaN0KR2N4/g
 TMAsw1Cw3QTnyFmORnW6TLTEPShTkAxeTlAQNzTcOyKObXL5H6+NzJR5EkpDlq9+JLLxvQk
 AX9p+UA4Hv0+xS6COut3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N40ZlTNFFpU=:I/RrexfkbSrgJkSEOOlm9p
 PKe34kwV7q88gW9HKdwb9atzK9LlnzOiqkDm1H9OQmdHf5VWgqxR67gvXJrYx3HFNSW1eY+3z
 dv3/H7amJt3Hq9CQ9XY11JMYjb/qB18mxDuFoj3i6C2AitSjyfeV9IC3eAvHq+8z2MB6BiZ/4
 gWrF6DZTRGxdNYBXQyJrZimJ1tzrFCaBoam00zq5K4JKAsgl3Rq46Rbuaolv2bAaoMknpyGKT
 W1KptyLOQywkQkdfxC0whturzIW8ZIzuOO8WMsfkprPrko+JSK8VVfV8kH1k3TkVFcJ+F/z/F
 rCQe5GIpy+AFvwZFg5vB18vHYi7AdWcKNCQlCgsAmP855qCPdu1Ze8Jwa6/blRpTu+xyT1u2u
 fWWoA6A0c5DqDm6oC/DVjmzjH0pDAKk3ylJCLd/F33Ba5/cZxmC/JmROQdXb/h7YTeBwIugLK
 geCYIJYG+K/qEtvtbZJAr+7nxVwHAthp07GjlA4PdHCnoKafmiTif8vMSoXd8byjeIKJ13O8p
 GsNgT+v4t91miLYIf+lVvtiWMBq3qu7DawonN9lpJeuU+H6m7Bkv2LySepNZOsg0jAq8I0RIS
 y/4xTV4biQARRyvgmTTC7WRIGxlw/5M4VRfi3tAAvTFeJ6Q1eyFbnXqjzhf7asyuQh45SW0VH
 NQCzB/GCHyCEYd5mM5h1xPtxmLNNWjcOzoRRrzXXm1nSmB4rIh53peKZlGEJT/ezFHvOvvZgj
 ULNA80dp1pJScu+tWMxttCFZ0R1CwidyxjJtoksTYScfcBDQ1yy6BzYUn3Vnd3F3WFGQnxK1j
 xKjwKE196aUDo+p4quuMnl7ByjG41gC0jsksnJ+GimYYK//1eqZuq9qsjUdvvOb+LSMmPZJRq
 kyYL0zaiMSANlZ6/+Ha6NfKrfqbbm/UPIcY0qas9crFtDModHX3YDKxt1UtVtBWli+eqKJPhv
 khrTVmMlUqoYxq55ERQ3Ou6k6nVHE8UjPRBvve4eklhem2uAKlajp0m7O7VpzVJvPP/PIu5B6
 Q03aH1iQnxs2ipfJhgTua4HECtP81o7xPc6GR9e4mRQVcR79V8FNDVIrzMuJxnH0YbKtbNrba
 Mhx1aWZKNm1bjWdyf7AhCyNzY7DNUtDJhPAxn4ElyXUIUMjztoFNCLc1g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to boot a kernel (with UEFI boot) which wasn't able to mount
its VFAT boot partition afterwards due to unsetting those config options
by accident (=3D=3D stupidity).

IMO the 2 former ones should select and pin their corresponding
partners, or?
=2D-
Toralf
