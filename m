Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADEF309C74
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhAaNti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:49:38 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:28054 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhAaLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612092442;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
        From:Subject:Sender;
        bh=W0NnNAnTTRHvU5q/pSan3yLVtC/jTxPWsuyVvRo5msA=;
        b=mT9Gdixx30qVSFuINxhu2ki3TivMtr7MoSTIt4ESAjJ75y+ZyFkdNBhxT89DcpWq+A
        8739AA31UvjjUH75mAtK577HWSRhF8zfZgWFrzLI8D7TNZ7uDX3Hsxi3sx5O/8XsTNw6
        8vnf4k5+70DL0klhfV8jhhfsroUbpYXOf93wLqGXiBiODHNnzFxsqC9UGeYD9ffOHD4B
        r1K3a7K+V/CwUOHHnpwXhZuvVHJAFspVYddq83OcbnTexwBu06kb/5BmUIR55cAcjGBR
        ddkzRi9H/D0n7i1/wua8Nq2TL/wcIV4bTMmZ00Zu92BzU/7RyE8oIG9pbIEYZDZ1ujaH
        xlag==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMkw43k+w=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.16.0 DYNA|AUTH)
        with ESMTPSA id R01a2bx0VAsICod
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sun, 31 Jan 2021 11:54:18 +0100 (CET)
Subject: Re: [Letux-kernel] What ist the standard way to define connector type and bus format with device tree?
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CD0942AC-045E-41A2-A24F-F368C9438899@goldelico.com>
Date:   Sun, 31 Jan 2021 11:54:18 +0100
Cc:     Paul Boddie <paul@boddie.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F038EBE2-132E-4390-85E3-74AE9FB512A2@goldelico.com>
References: <CD0942AC-045E-41A2-A24F-F368C9438899@goldelico.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

> Am 12.01.2021 um 12:41 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> Hi,
> according to bindings/display/panel/panel-common.yaml
> and by using "panel-simple" as compatible string we
> can define almost all properties of a DSI panel by a
> device tree entry.
> 
> Except the connector type and bus format which can only be
> set by adding the information to the panel-simple tables.
> 
> This leads to big problems because DRM can't match the
> display with any lcd controller. A smaller issue is a
> warning:
> 
> [    0.313431] panel-simple claa070vc01: Specify missing connector_type
> 
> Are we missing some documentation or code that reads
> some "connector-type" and "bus-format" property?
> 
> BR and thanks,
> Nikolaus

