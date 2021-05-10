Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F3378C07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbhEJMWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:22:03 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:55046 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236883AbhEJLKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:10:54 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id DC531837F24C;
        Mon, 10 May 2021 11:09:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 1234CD151A;
        Mon, 10 May 2021 11:09:46 +0000 (UTC)
Message-ID: <44c7c5088268aa010566ac3e38023449a954aec4.camel@perches.com>
Subject: Re: bug at scripts/get_maintainer.pl with ARM KOMEDA DRM-KMS DRIVER
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 10 May 2021 04:09:45 -0700
In-Reply-To: <20210510123458.32f931c6@coco.lan>
References: <20210510123458.32f931c6@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 1234CD151A
X-Spam-Status: No, score=-1.40
X-Stat-Signature: ttj8uqh8aabmbnwycmad583jo56gynze
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/SBsl4COeFjsxghKR8GRRxt76SBBiEnTs=
X-HE-Tag: 1620644986-560312
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-10 at 12:34 +0200, Mauro Carvalho Chehab wrote:
> Hi Joe,
> 
> While submitting today a patch series, I noticed that the
> ./scripts/get_maintainer.pl script is not handling well the
> ARM KOMEDA DRM-KMS DRIVER open list entry at MAINTAINERS.
> 
> I'm using v5.13-rc1 here.
> 
> See, it gets an empty e-mail for the ML:
> 
> 	$ git show a1c3be890440 --pretty=email|./scripts/get_maintainer.pl 
> 	"James (Qian) Wang" <james.qian.wang@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
> 	Liviu Dudau <liviu.dudau@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
> 	Mihail Atanassov <mihail.atanassov@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
> 	Brian Starkey <brian.starkey@arm.com> (supporter:ARM MALI-DP DRM DRIVER)
> 	David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
> 	Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
> 	 (open list:ARM KOMEDA DRM-KMS DRIVER)
> 	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
> 	linux-kernel@vger.kernel.org (open list)
> 
> The entry at MAINTAINERS apparently looks OK:
> 
> 	ARM KOMEDA DRM-KMS DRIVER
> 	M:      James (Qian) Wang <james.qian.wang@arm.com>
> 	M:      Liviu Dudau <liviu.dudau@arm.com>
> 	M:      Mihail Atanassov <mihail.atanassov@arm.com>
> 	L:      Mali DP Maintainers <malidp@foss.arm.com>

Perhaps these "L:" entries should use "M:" instead.

Is this actually a mailing list or an exploder?

If it's a mailing list, is there a public archive somewhere?
How does one subscribe?

