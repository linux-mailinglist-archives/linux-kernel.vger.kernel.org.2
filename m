Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB741EEB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353839AbhJANmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:42:10 -0400
Received: from srv6.fidu.org ([159.69.62.71]:47154 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231699AbhJANl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:41:58 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Oct 2021 09:41:58 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id C5D98C800C8;
        Fri,  1 Oct 2021 15:31:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id IzwXDPWNr8OB; Fri,  1 Oct 2021 15:31:28 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 5A8E9C800C4;
        Fri,  1 Oct 2021 15:31:28 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ALSA: hda/realtek: Fix name and add quirk for new Clevo
Date:   Fri,  1 Oct 2021 15:31:09 +0200
Message-Id: <20211001133111.428249-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk for Clevo X170KM-G to fix internal speaker not working and rename
previously named "Clevo X170" into the more verbose "Clevo X170SM" to make
the devices differentiable.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>


