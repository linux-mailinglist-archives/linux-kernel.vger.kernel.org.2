Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1611539DD62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:17596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhFGNQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:12 -0400
IronPort-SDR: 1nuFiyBydA7TbiyN1ZuFLK7W494n6itT+bRMFdWwNaCCDhs5cGqd1HcWTfX6s6Vdhu2KTiBsf6
 9UDpWM9zFqmg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265773960"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265773960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 06:14:20 -0700
IronPort-SDR: cuSMWITX6jWJebNtdUTONbMsYtQNUWTqQbS9AeSnPei1BERjI6ODevxombFvPvx0FC3Llv8ipO
 ddpyxbiF0JsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551881850"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 06:14:18 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] usb: typec: ucsi: Polling the alt modes and PDOs
Date:   Mon,  7 Jun 2021 16:14:35 +0300
Message-Id: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the RFC series I promised [1].

I'm sorry it took this long to prepare these. I had to concentrate on
other task for a while.

Let me know if you still see any problems.

[1] https://lore.kernel.org/linux-usb/YKT3oEt%2F9fX8k8mw@kuha.fi.intel.com/

thanks,

Heikki Krogerus (7):
  usb: typec: ucsi: Always cancel the command if PPM reports BUSY
    condition
  usb: typec: ucsi: Don't stop alt mode registration on busy condition
  usb: typec: ucsi: Add poll worker for alternate modes
  usb: typec: ucsi: acpi: Reduce the command completion timeout
  usb: typec: ucsi: Process every connector change as unique connector
    state
  usb: typec: ucsi: Filter out spurious events
  usb: typec: ucsi: Read the PDOs in separate work

 drivers/usb/typec/ucsi/ucsi.c      | 317 ++++++++++++++++-------------
 drivers/usb/typec/ucsi/ucsi.h      |   3 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c |   2 +-
 3 files changed, 183 insertions(+), 139 deletions(-)

-- 
2.30.2

