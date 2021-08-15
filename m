Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460933EC6A3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 03:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhHOB1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 21:27:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:34789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhHOB06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 21:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628990774;
        bh=+ED+s6+aMS+LaOlqxVwFk7EbYzGiZJ9DpvcBn5G06lw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=MeeQ0rAo1ZfDhKN2e4qoP4vx70NLkinZMf3XBiRf+4aWTyci+nTQeqsCZdBtNtbn/
         ZeU7PbyTeJfrSZUZr2a9uT2Xa6NjN3F7bnJnkTKEj1PGY3QmwU6QN9O1LU4qy7v9zD
         mRcRyMNHgOigqfmrxgz6mw3ZqSJab8pR6vl+hF8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.238]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1mILco1ISq-00Gb0t; Sun, 15
 Aug 2021 03:26:14 +0200
Message-ID: <b761c7a33c563a8f374b707f421ddfd6460c9d19.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Sun, 15 Aug 2021 03:26:13 +0200
In-Reply-To: <94d74c8a-1e10-2500-468a-11c0ae7e2417@suse.cz>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
         <20210812151803.52f84aaf@theseus.lan>
         <8c012c35852e98af99a6b6234a3f57ac27cd980a.camel@gmx.de>
         <522000b97adcfbc581e7e5ed1afc94519b1388b8.camel@gmx.de>
         <94d74c8a-1e10-2500-468a-11c0ae7e2417@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FTuY8CQuB0praANkNxv5OfMO+Jvnx8F4CVZIenLDgwIE2VXn1+/
 TfNgmHLUMKtkr9dtMNCJZhxu6cIir0MCi/+/ygJg+BKwz8ELFTiuGfWKlbiCOTNkkkSA7bh
 4AAbTukHf8Q7Msmn2Io7Cm1gnyoVQlizburMWeAybc/hJt/veRNuIuoa88Xbn7UbczNZ08W
 HcBV8LzAy2QMtlIcBaN5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5q7snrvA6LI=:6zO+wvz00meFrH/aRD9GjM
 Rrv2/tLM/w3M+W4e8a0Hhu9Erq+n0oEz+dHW8vRyNCz9oXOkiw6U6Xrb4Y4Du4eWLXM6s++tv
 uF1m8M0fUwrjDgiwW9D+ECXQCcHb14wR5S/qEWv/ReD4Y2RUD5UWKrRFHPrVpdO2GQXdCYi8z
 WfIAIOothI9jiGSvwX4cdPq5Gda6Drkbd69PXmsM4EpAI6FYBbMZZImmpb3PxkjYiks+9HLkb
 Gynw1TV14+QR7/Puo9afEuDS6e/kVqcTNhCfw6jmvYrprmn2rgH8fn0FGGF3DZ9oPAWvnOSS+
 Fzzfr3hsOxX6R9FBuqXEAo94M4+fMe1Pw8LpZ6sSZHAo3ZL/MwmZ69UcXvomVjbdeU4BCdWLB
 jFVSTl4YXJEJl0ws7PLNw3PrlwrYU81mFsM8IYfdqX3mjO6SGInTp+uvXjVzVqnDF3SAwRPzD
 fqW6YCh1DL90ge15tRNQmd249bktYJkwBh9NF2SEjfORelMKUkkkp0lMXEKW8mnbZNClPM4Y5
 1g4UEPDYe7DgcPnPGIPREr6SwJYAYJSYeU2ee0Tg2MvPtnJ+IM0QSUzZdYGbVteladbQ6jR2R
 K574/JSxRhXkNLLYEnIKCZEJc0aOJuYEyzoa2qNLvvWbs6f4gBm3m9gsmiYRdRfcA6bp+8hqa
 0e14ZrodVFJzbTkukqVbB6YkG2NVu8UYKAQqQefrx4XO7lA6/86zYT3GWfbh10wi8sRDG6T8x
 oGUXmSTd92wz7Ca7wLMdvJSQwcQCKHpwSQ7qYfY+OHu/eQfTc0dAFIncZBCZCiHZHxaj1Pw9s
 5rm+Pw3N/OgePetxM0Bb1/51oEdjQQL8zCG5ru/E2m3h/cZqgF/Jf0JUes0fgtsx1VfliCXAJ
 lAdiKbpMHWqK7w8BVKZNI5pUfWpYr44rRiB9Yw/QyCGQ/3d3K+fAUSYBA1g7kzi4jkKzK+6mz
 VliaIrVSB+b+iX0HhSwf/UITIWSxwGquNUWBq2wlaErT5DvHw+sCn2LfaVQU2ykbN+WTCayPG
 Fo8ogJCoNYsmZhQsqf3KzLU6H/Uj8RCav8LUjg1W1A4UyQ34qTc+Oz61QSjIwrd8wUunMWavR
 yNh3kTWBbesbwn7B0YC2Kbh0jCllUZ4kIdd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-08-14 at 20:28 +0200, Vlastimil Babka wrote:
>
> Why didn't you see it in earlier testing though? What's different now.

The provided debug options make the difference.  Without that pile, an
otherwise identical config will happily slog away for hours, add them,
it's a matter of minutes.

	-Mike

