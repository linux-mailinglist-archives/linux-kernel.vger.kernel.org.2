Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA58313591
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhBHOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:49:49 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:50454 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhBHOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:40:39 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@angband.pl>)
        id 1l97fY-007v7s-GU; Mon, 08 Feb 2021 15:37:40 +0100
Date:   Mon, 8 Feb 2021 15:37:40 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Wadepohl, Wolfram" <wolfram.wadepohl@storopack.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: TLS for 5.10
Message-ID: <YCFMtITKsqgoahKT@angband.pl>
References: <9d7203defadd4cf3a1ae3f4a5f827ed3@stpinfexc1vp.corporate.storopack.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d7203defadd4cf3a1ae3f4a5f827ed3@stpinfexc1vp.corporate.storopack.net>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 07:08:05AM +0000, Wadepohl, Wolfram wrote:
> I'm sad to hear that 5.10 has still an EOL of Dec, 2022. We are in
> development of our 1st GNU/Linux based System,  50k devices for IoT.
[...]
> In general a 2 year support for embedded systems in automation is not a
> reasonable thing. Nevertheless the CIP project has commited to 5.10 as the
> next SLTS kernel.
[...]
> What can we do as a very small development team to support an extended LTS
> period of 5.10.?

The two years are a minimal promise from Greg.  Debian is using 5.10 for
upcoming Bullseye, thus even if Greg won't extend (99% chance he will), Ben
Hutchings will continue the support for as long as Debian Bullseye is alive.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
