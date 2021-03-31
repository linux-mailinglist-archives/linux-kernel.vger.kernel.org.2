Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0B34835A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhCXVCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:02:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:18808 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238191AbhCXVCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:02:12 -0400
IronPort-SDR: GLoPmqQv2WZPD3A3MUCmOym1RZ/FoVkRZm6BbtEGY/VWuOWoje/EJYLDR55HZK0VAKg8ko40Bw
 /bqNGtF1anzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190812791"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190812791"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:01:48 -0700
IronPort-SDR: wwhRyBjPPefLY4IAS+Rz3oLkuXqEtbueYf0s/cpm+RllwF+CrMA+N8zBJsUX+Xzj/SKGEeEM9W
 e3xD7zweg9RQ==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="415655947"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:01:45 -0700
Subject: [PATCH 0/4] cxl/mem: Fix memdev device setup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:01:45 -0700
Message-ID: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small collection of fixes mostly inspired by Jason's recognition of
dev_set_name() error handling mistakes on other driver review.

dev_set_name() can fail and although device_add() might catch it that's
not a reliable assumption. While fixing that I noticed that the unwind
handling for cdev_device_add() failures leaked the device name.

The sysfs_emit() fixup and unpublishing of device power management files
are just sanity cleanups.

---

Dan Williams (4):
      cxl/mem: Use sysfs_emit() for attribute show routines
      cxl/mem: Fix cdev_device_add() error handling
      cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures
      cxl/mem: Disable cxl device power management


 drivers/cxl/mem.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
