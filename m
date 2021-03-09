Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA7331F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhCIG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:27:49 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117]:47404 "EHLO
        esa4.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhCIG1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:27:40 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 01:27:39 EST
IronPort-SDR: Cb9ql9Ynuaut7MWvI5r/4uX+WPSVVlfk6CB6PPjlXPyz/m2dxfOWJPvdNj+AEDS2Y+2zYIzgCk
 r5QclFtoTwCS3799sJVqc1TduT9nd/th7qZnfR7C2l4UECCRgQkkaRzHnvGwDrkm2y9SkTd0DK
 DuARi25GuaSLK0FkOSMBFBc9t0dlQXzeZKG9U88M4BzOtLtqnavAz5WYYDe76FNfZ8rPR9ce4r
 7eU/evN3NYaXiK8BHMA+2cXIxnQTIQ7jbgpqda6wEX5/AvgHRhwRdCA6Spfm8n34egLqDd7Ekh
 J30=
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="22170783"
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="22170783"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 09 Mar 2021 15:20:29 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4DFC31F514A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:20:28 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8856BC9CEE
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:20:27 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 1C4FE4008A2EC;
        Tue,  9 Mar 2021 15:20:27 +0900 (JST)
From:   Yuichi Ito <ito-yuichi@fujitsu.com>
To:     maz@kernel.org, mark.rutland@arm.com
Cc:     Valentin.Schneider@arm.com, catalin.marinas@arm.com,
        ito-yuichi@fujitsu.com, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@arm.linux.org.uk, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH v2 0/6] arm/arm64: Allow the rescheduling IPI to bypass irq_enter/exit
Date:   Tue,  9 Mar 2021 15:20:07 +0900
Message-Id: <20210309062007.1600708-1-ito-yuichi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f7a1cf64f8e0181a18e2b117b61622f4@kernel.org>
References: <f7a1cf64f8e0181a18e2b117b61622f4@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Mark

> Mark is working on this, I believe. I'll let him comment on the current 
> state of things.

I understand.
Mark, Could you tell me current state?

Thanks,

Yuichi Ito

