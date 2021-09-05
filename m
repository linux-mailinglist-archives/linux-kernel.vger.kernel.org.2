Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3940101E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhIEOSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 10:18:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:53037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEOSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 10:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630851397;
        bh=3qmO5ehutY9JAMM/HBjYS1HtKYX/lmJDQxzvtdmPU54=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Sird1dtnDJcQNkfYAsZdgjHRrijpvXkxRklVcb1flv9jU8oHQ81PusNHYyytwtQT/
         GKlfMq3K+iNQmz9i4akzAYtQLjiaLLM7tW7apMkl+nvSQCf3m4DZIaio/MV/stR2f6
         /7B8LDFZZEYRmH3sDY1WhAk/YhOd7zGvQKIVRUJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.159]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1mH9f410wd-00BsqI; Sun, 05
 Sep 2021 16:16:37 +0200
Message-ID: <89ba4f783114520c167cc915ba949ad2c04d6790.camel@gmx.de>
Subject: Re: [PATCH v6 00/33] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Sun, 05 Sep 2021 16:16:33 +0200
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4e+vYLUHAhuYRHLMmrCJJziDWGVmoPHY55k+ULjGSRh4JwZ2pKH
 CmHFxCMMcJG3Wo+/e4OqJj//2YENq4XdvfqBIbtdJA4mry4Sc06rTWADbxj9RmyauIbkMUc
 msmxRKsprZ7tF2OUcovTzOWaj2XCVLvP2x6ZNBtTI+PwhIQ+61SbYoycHzH6+KpdqC74vAh
 FVgXx4vsEGdXaGtlko94Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TE7xvGKfCf8=:cBYdGYj6AM/VHTUvu9eyzv
 StuTZsakvBZb1PVU2d2EqN2DbCVTWL1bGQyZKJ+1TDwKfvx1Z7RCDXqdeuUwRxripIZHfckzy
 qMaWyzvFJuIfqYNDXojzb2gxnSMUiiCUU5vIuapZZDXe72nZfOfvY3XBs4XTLLPxkEmE2W0//
 F36/iW2djezfwYN2IJNIT9TwqPEHswk2orJtv5zJwh0KgU/OqpQIhePMKz5tmPYf4h/nehsKB
 j3v/BgGMN8Cm3R1G8pYjWGOiGSzqStM8NwHM7YPgm1B+Jg1aEYiCfwJQhgWMNODRMWjmqlAsV
 CsoDUCAWGiaBvHNE4lByVSrAQS65xSzai1D9ti9+0GgSSDvZwdTUZdT+ZzHuU3nMmatbF4Edm
 SYidr2KW8TgGxzFXAD6m275k+Hih4OoUVff9BORVzbb/POQ48WsuRxsojdIZSo2kfkX0a8Vya
 dtMyfZZXuf/cqhppdIUQWExMxBHfbqEbPiURkFRLAuvCti6PoPYOQ0INHMQGfzoaWGO+a4TnP
 7R4CVI2Yg5XQ1eNCYEXZKMfssZ4baCbbjJm7f9dpdpeJFdYCeDdHg8QIJ/dec+LqpmURw2OEK
 LbNrtmAI+hRxQn1teZfadWDnQUvRdgNs8u/On4QUBYC7PM2xlZu509q+/FRQFR3aqdhb61GDT
 RmTaIXT5UytQBY+7sBDt8Mn7uuTH0ggSDOt4GNxPUo8eNg/JXtd2cQnLTfed7ndCMCk71Kpvh
 SY9esJnFOdIxAaI9DEVi3IN9GYTktjrlC/6++jv2eM5NhLek0h5jDctwqnO37dpvh5cReNuln
 zCTINMn5nVM8ST38a3qLEFyF/zEUIElzZUyPe413CFXdVvYpAZnGAuLCJz1FXq8mI+PkctQW7
 f9ltl2CIlm5PQqGEekWAOfGgZ7XgedokJGHOOpba5Cl/JLhI/VuMWT5mloTEqR5vnfKDoex3g
 btbLip9q/nGfIYnOA0A8qEgOKj7tBpCWvxnyewDUhnxn9qWnKdZ2J0ktCMksjJBAI7cPEOJg2
 osTz00j6VW3kE7DOxFf1t6sf9j7NgIw7OzRLpEAqOcJc5jPFyIAuEtlf8RdYKmuAoT3ppPLNL
 sXshXStOaxFcEJzJVHdY+xC0pTt3Hu3AOqM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-09-04 at 12:49 +0200, Vlastimil Babka wrote:
> I will of course continue testing, as I hope Mel and
> the RT guys would soon too.

I stuffed the set into tip, tip-rt and the raspberrypi 5.14 branch
kernel+RT, and let my boxen run full LTP for exercise. As expected,
nothing the least bit interesting happened, just a bit of run to run
result diff noise due to.. deterministically challenged testcases.

	-Mike
