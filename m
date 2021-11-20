Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC6458076
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhKTVb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 16:31:59 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:31164 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhKTVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 16:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:reply-to:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=2YVFG8rXs343RWVI4tYPz7yQFnNdAHvRj9hz5T7vhuc=;
        b=gyVsLnsajHq48KpoDJqP7YPrGsKXCcZwxlYbhkZ/WK722WhzELM2bD1NjKnpbc2npSNu
        kXD/xBOV+FMSUvPVAZM2Wo1Gkl5jqNPDSfGE/BFY06Edhxu0V0E2VwjziO27CnLrrq+3fZ
        J/XsWqbWTPcYZJvlcRWooFCkqiEUtmWP++vp1mJGK6XAUgD4Fp4GI2YUmPaWRvRyaCt72k
        UeIYOilacg4ZrtJ2W/MtP4gN5Y16lYZUN7uKQ5Z5J8uMUFSKGpmv1gGvIhydNQq4DxG9IW
        iWM4FH1aEu6CXkSXRaGzuXhYQpC5wXe4TDpBvRkNQyyjbPR3WmlZN11FVTgbi1hA==
Received: by filterdrecv-7bc86b958d-j46hl with SMTP id filterdrecv-7bc86b958d-j46hl-1-61996895-8
        2021-11-20 21:28:53.293948255 +0000 UTC m=+6908936.763879279
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-canary-0 (SG)
        with ESMTP
        id v_a-GEEkTHebqNQFevbQ7w
        Sat, 20 Nov 2021 21:28:53.121 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 8FB83700297; Sat, 20 Nov 2021 14:28:52 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v3] hwmon: (sht4x) Fix EREMOTEIO errors
Date:   Sat, 20 Nov 2021 21:28:53 +0000 (UTC)
Message-Id: <20211120212849.2300854-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211120204053.2299501-1-davidm@egauge.net>
References: <20211120204053.2299501-1-davidm@egauge.net>
MIME-Version: 1.0
Reply-To: davidm@egauge.net
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvPgxd4FR=2FL1UwwCjk?=
 =?us-ascii?Q?vPEKTUi+iofSmiXNxhYZGOHduPBzFvlIRNm4Cdh?=
 =?us-ascii?Q?XkUQpQImwT7eQvvHfPXLwLqCqmCZJ27+zojJWC2?=
 =?us-ascii?Q?J6mQ2oGSL2rENAlzM19c10ehZff+uxrAp6PVzgU?=
 =?us-ascii?Q?chwc2r5kIEYtGrFzBvheAFf8ebpetXKaBxBhi9i?=
 =?us-ascii?Q?jozThaLA=2FsvPylyu4V2qQ=3D=3D?=
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repeat of previous patch but split into separate emails so the
device-tree bits can be sent to the proper group of maintainers, as
per Guenter's suggestion.


