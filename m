Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43B137FC6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhEMRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:24:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhEMRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:24:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id B01E71F4043E
Message-ID: <eb23c9e400afa67739096fadd95345e951360bd7.camel@collabora.com>
Subject: Re: [PATCH 0/3] regulator: fan53555: tcs4525 fix and cleanup
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mark Brown <broonie@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 14:23:19 -0300
In-Reply-To: <162083902381.44966.4390626020202703159.b4-ty@kernel.org>
References: <20210511211335.2935163-1-pgwipeout@gmail.com>
         <162083902381.44966.4390626020202703159.b4-ty@kernel.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, 2021-05-12 at 18:04 +0100, Mark Brown wrote:
> On Tue, 11 May 2021 17:13:32 -0400, Peter Geis wrote:
> > The tcs4525 voltage calculation is incorrect, which leads to a deadlock
> > on the rk3566-quartz64 board when loading cpufreq.
> > Fix the voltage calculation to correct the deadlock.
> > While we are at it, add a safety check and clean up the function names
> > to be more accurate.
> > 
> > Peter Geis (3):
> >   regulator: fan53555: fix TCS4525 voltage calulation
> >   regulator: fan53555: only bind tcs4525 to correct chip id
> >   regulator: fan53555: fix tcs4525 function names
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/3] regulator: fan53555: fix TCS4525 voltage calulation
>       commit: f8c8871f5eff3981eeb13421aca2c1cfda4a5204
> [2/3] regulator: fan53555: only bind tcs4525 to correct chip id
>       commit: f9028dcdf589f4ab528372088623aa4e8d324df2
> [3/3] regulator: fan53555: fix tcs4525 function names
>       commit: b3cc8ec04f50d9c860534fe4e3617a8d10ed9ea9
> 

I know this is already applied, but since I tested it,
this indeed fixes cpufreq for me:

Tested-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks a lot for taking care of it!

