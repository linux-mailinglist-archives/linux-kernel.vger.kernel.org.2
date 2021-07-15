Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EC73C9612
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 04:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGOC7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 22:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231702AbhGOC7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626317808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6BpdxiNkUt9kqi7hW+DS0myRIRq5y7TUOmZb/Eo/lOA=;
        b=OhcNM/x972zYMyPuMKcGZdLDGXa1EUa5oTwtMy0HEY6P1M5yNWGe9IgplO32MVaEOpV9tX
        g+eJXqdbtNx0f1Hl6OgCJbmOYpmRuW2XRHJ3Fiu5qctaqYL8vk88cD/i0WkYXVBtI7vBIt
        EeojGhLsMHOBfB/H+6zxzJ/r6rBfsYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-0IPDXgPqM1K6Y9W8YejNjw-1; Wed, 14 Jul 2021 22:56:47 -0400
X-MC-Unique: 0IPDXgPqM1K6Y9W8YejNjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A132636254;
        Thu, 15 Jul 2021 02:56:45 +0000 (UTC)
Received: from dreyauc.ausil.us.com (ovpn-112-46.phx2.redhat.com [10.3.112.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C2961A872;
        Thu, 15 Jul 2021 02:56:44 +0000 (UTC)
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     linux-rockchip@lists.infradead.org
Cc:     dgilmore@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: arm64: dts: rockchip: helios64: SPI, tsadc, and stdout-path
Date:   Wed, 14 Jul 2021 21:56:28 -0500
Message-Id: <20210715025635.70452-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropped the USB patch from V1, this set enables the SPI flash and sets
aliases, enables tsadc, and set stdout-path

Dennis


