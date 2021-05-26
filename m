Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33A391C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhEZPhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:37:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:51469 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232023AbhEZPhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:37:00 -0400
IronPort-SDR: 76/cb8AcpFxHaGYevWn1WqdOhmSv+CVW87ay8WMlyINDJ1OKYlDerFiH9YMk/js2fEZehq5LJs
 +Tu0Z/Iowj7g==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202529805"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="202529805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 08:35:28 -0700
IronPort-SDR: 1ydds1PjwrCI9xbX9aY0Xij9f0HuFGXd6BaPte1ufpb20YGsSZIyndjNUb7j9A6ZswRXlyRbeZ
 fh7z0fr3pvpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="547236490"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2021 08:35:26 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] usb: typec: mux: a few improvements
Date:   Wed, 26 May 2021 18:35:46 +0300
Message-Id: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first patch should be trivial cleanup, but in the second one I'm
removing the condition that in practice forces the orientation switch
to always have the device property named "orientation-switch". This
change only impacts connections described with device graph since only
in that case the callback function is supplied with the "id" parameter
which is the first part of the condition (if the id is not supplied,
the function also does not expect the device property to exist).

But when the connection between the connector and the switch is
described with device graph, I don't see any need for that device
property. Therefore let's just remove the condition and the
requirement for the device property with it.

thanks,

Heikki Krogerus (2):
  usb: typec: mux: Use device type instead of device name for matching
  usb: typec: mux: Remove requirement for the "orientation-switch"
    device property

 drivers/usb/typec/mux.c | 29 ++++++++++-------------------
 drivers/usb/typec/mux.h |  6 ++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.30.2

