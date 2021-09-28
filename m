Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8185641B36F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbhI1QD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241600AbhI1QDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68DF1611C3;
        Tue, 28 Sep 2021 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632844931;
        bh=Ypn3HojbrbT85EaaveFSw1KfwVtIAUxWUpfMV+DHwdU=;
        h=From:To:Cc:Subject:Date:From;
        b=lezL/G+3lfwwV2RmwLTSTSq8K8omcO2qR7k52ce/Yfg0xDNpbE3tC5EbYESPojYk5
         0Fd2tjFAOJR/6oAzAmIhTg2Pv3+GmE0zpgRzCQHODOBIuWx/vXgWXmwTSb7GW75hyL
         VkBLQhVMclzASQYC9ss1bmbbzTqiSZnTtosedf2mWCtJG5nsGGAOpkTPfvz4D4Oatt
         N5iPHIn7RwglVH8iXzPXD/dVpaLeI1YTTp/OANST0kCXDd2mc4cQnySO/fvscXWlQC
         qN2K5iiduSj0rw5dM6Q2x62oE1PiURVu0CYygYkelpI/O6uGY4tIS40NusZPpav6kf
         C+5uWtlOPG1ug==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVFYX-000Y0v-BN; Tue, 28 Sep 2021 18:02:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 0/2] ABI: add entires for MCE
Date:   Tue, 28 Sep 2021 18:02:01 +0200
Message-Id: <cover.1632844726.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While checking for missing ABI documentation using get_abi.pl, I
noticed that there's no deviced MCE symbols under Documentation/ABI.

There is a documentation elsewhere, but it is incomplete.

So, add one.

Mauro Carvalho Chehab (2):
  ABI: sysfs-mce: add a new ABI file
  ABI: sys-mce: add 3 missing files

 Documentation/ABI/testing/sysfs-mce | 129 ++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-mce

-- 
2.31.1


