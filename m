Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48B37859A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhEJLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233159AbhEJKpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:45:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 045A9619B4;
        Mon, 10 May 2021 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642903;
        bh=a9r/SweXO9D14zFErMPAxQBy78bSI1FMSyuwH98aCE0=;
        h=Date:From:To:Cc:Subject:From;
        b=YLeAckrq0eFN33LG/VQvScKWn8GV7OdKsw/qqeKk9SCPzyEB4SUJ4qQmws1fHnwPI
         WyCveMa51gP2ZMDkNxJ2SAzT69rU+ragvjNhqkImXvfphTfCwESvn3jaIQvdogc8qi
         6IQV+dS2RVek8fZB5jRa7OuusJiS7Pk9K96IibR9oYP9X1JY9zOIEACH3vAXinpJym
         Xobxk4JH8asMFVm252z39u3j4st2j0Gkd8mGI+mQVmklSHa/7PzlRIHrQgTl8deeKo
         5F2uQcQxRZsz+awHzg9JnwAYQajArknw84PORWfKDm18+BN10O7B4Mm7/JaZq/4oYi
         chbQJdAfrmeiA==
Date:   Mon, 10 May 2021 12:34:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: bug at scripts/get_maintainer.pl with ARM KOMEDA DRM-KMS DRIVER
Message-ID: <20210510123458.32f931c6@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

While submitting today a patch series, I noticed that the
./scripts/get_maintainer.pl script is not handling well the
ARM KOMEDA DRM-KMS DRIVER open list entry at MAINTAINERS.

I'm using v5.13-rc1 here.

See, it gets an empty e-mail for the ML:

	$ git show a1c3be890440 --pretty=email|./scripts/get_maintainer.pl 
	"James (Qian) Wang" <james.qian.wang@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
	Liviu Dudau <liviu.dudau@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
	Mihail Atanassov <mihail.atanassov@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
	Brian Starkey <brian.starkey@arm.com> (supporter:ARM MALI-DP DRM DRIVER)
	David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
	Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
	 (open list:ARM KOMEDA DRM-KMS DRIVER)
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
	linux-kernel@vger.kernel.org (open list)

The entry at MAINTAINERS apparently looks OK:

	ARM KOMEDA DRM-KMS DRIVER
	M:      James (Qian) Wang <james.qian.wang@arm.com>
	M:      Liviu Dudau <liviu.dudau@arm.com>
	M:      Mihail Atanassov <mihail.atanassov@arm.com>
	L:      Mali DP Maintainers <malidp@foss.arm.com>
	S:      Supported
	T:      git git://anongit.freedesktop.org/drm/drm-misc
	F:      Documentation/devicetree/bindings/display/arm,komeda.txt
	F:      Documentation/gpu/komeda-kms.rst
	F:      drivers/gpu/drm/arm/display/include/
	F:      drivers/gpu/drm/arm/display/komeda/

Thanks,
Mauro
