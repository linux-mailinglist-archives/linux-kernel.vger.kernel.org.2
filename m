Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F71378AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbhEJLze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:55:34 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:54350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234630AbhEJLFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:05:09 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 819F96C11;
        Mon, 10 May 2021 11:04:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id A71BD13D99;
        Mon, 10 May 2021 11:04:01 +0000 (UTC)
Message-ID: <22f25cc644dea4ab42ddb7a5f177d6eadc18f93e.camel@perches.com>
Subject: Re: bug at scripts/get_maintainer.pl with ARM KOMEDA DRM-KMS DRIVER
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 10 May 2021 04:04:00 -0700
In-Reply-To: <20210510123458.32f931c6@coco.lan>
References: <20210510123458.32f931c6@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.61
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A71BD13D99
X-Stat-Signature: xscigx4xi7i9zjdak787cpwjgrt5rezz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18llAy+M+XZuz+RIpwwLsQDxL0SGi+D/wI=
X-HE-Tag: 1620644641-113795
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
> 	S:      Supported
> 	T:      git git://anongit.freedesktop.org/drm/drm-misc
> 	F:      Documentation/devicetree/bindings/display/arm,komeda.txt
> 	F:      Documentation/gpu/komeda-kms.rst
> 	F:      drivers/gpu/drm/arm/display/include/
> 	F:      drivers/gpu/drm/arm/display/komeda/

get_maintainer.pl does not support the L: using a "name" for the mailing list.
Only use the actual mailing list email address.

This should just be:

L:	malidp@foss.arm.com

so a possible patch is:
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..a41a26079806 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1383,7 +1383,7 @@ ARM KOMEDA DRM-KMS DRIVER
 M:	James (Qian) Wang <james.qian.wang@arm.com>
 M:	Liviu Dudau <liviu.dudau@arm.com>
 M:	Mihail Atanassov <mihail.atanassov@arm.com>
-L:	Mali DP Maintainers <malidp@foss.arm.com>
+L:	malidp@foss.arm.com
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/arm,komeda.txt
@@ -1405,7 +1405,7 @@ F:	include/uapi/drm/panfrost_drm.h
 ARM MALI-DP DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 M:	Brian Starkey <brian.starkey@arm.com>
-L:	Mali DP Maintainers <malidp@foss.arm.com>
+L:	malidp@foss.arm.com
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/arm,malidp.txt


