Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A965450212
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhKOKN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237566AbhKOKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636971000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spkFhHBfLWoUmEEFu9X0mCN465cERkwIsbNUF4+/SDk=;
        b=LWPrEfDFIf4R/CW7f23//a9eIPjpx9AVLWquDgMM6gwOrTlvJXpdGG8Olf87CQ05iJbwTp
        phPul1X+E3t/QxDNkpSLcDWrtZV+C/QXM7YYBGsS489+Big+Hu3L0ekEK0HrpD9GtoImiX
        yWnz1L4bW7TM7L98DudrJlcYTm+1E6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-4P8OZEEMO_C9S0E69bbHIQ-1; Mon, 15 Nov 2021 05:09:57 -0500
X-MC-Unique: 4P8OZEEMO_C9S0E69bbHIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59E1B87D545;
        Mon, 15 Nov 2021 10:09:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1653517C58;
        Mon, 15 Nov 2021 10:09:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5BF2918000A9; Mon, 15 Nov 2021 11:09:43 +0100 (CET)
Date:   Mon, 15 Nov 2021 11:09:43 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, mst@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211115100943.ezvirlrxc2qzms3i@sirius.home.kraxel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211114163958.GA7211@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114163958.GA7211@wunner.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Same for the 1 second delay in remove_board().  That's mandated by
> PCIe r5.0, sec. 6.7.1.8, but it's only observed if a Power Controller
> is present.  So just clear the Power Controller Present bit in the
> Slot Capabilities register and the delay is gone.

Well, the power control bit is a useful data channel.  qemu can use that
to figure whenever the guest uses the device (power is on) or not (power
is off).  And in case power is off anyway we can simply remove the
device without the attention button dance.

take care,
  Gerd

