Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2405130960E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhA3Ovj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 09:51:39 -0500
Received: from muru.com ([72.249.23.125]:55036 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231686AbhA3Orz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 09:47:55 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7768D804D;
        Sat, 30 Jan 2021 14:36:59 +0000 (UTC)
Date:   Sat, 30 Jan 2021 16:36:48 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCHv1] ASoC: cpcap: fix microphone timeslot mask
Message-ID: <YBVvALhY2oM/AMmz@atomide.com>
References: <YAqOSg2z24NpjKDh@mwanda>
 <20210123172945.3958622-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123172945.3958622-1-sre@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [210123 17:30]:
> This is compile tested only, since I currently do not have
> my Droid 4 ready for running some tests. Maybe Tony, Pavel or
> Merlijn can give it a go using e.g. arecord.

I just tried recording with arecord -D plughw:CARD=Audio,DEV=1 | hd
but only see the header and no data.. DEV=0 won't produce anything,
maybe I have the alsamixer settings wrong. Let me know if you want
me to try something else.

I do have the pending voice call patches applied on top, voice calls
work just fine with your patch. So as it looks correct to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>

