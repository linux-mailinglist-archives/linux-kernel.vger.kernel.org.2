Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188CD401B44
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbhIFMhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:37:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52363 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhIFMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630931762; x=1662467762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LG2IsHLY2etsqY1+L82PTNHRRUEHtb+Suet6zR7M05Y=;
  b=V17j5Atm/FrF6uHY+yTN1fS9xo9/2x03y6+swIHatfCXIdylEm8R6V7p
   4YXit2ljNcO7kQtPAJpQ1FjJvmbVAMS3mknZ6pz1SUW/243SAl9Pc2cKV
   btJe+TLFlRfl4+Od83La1RYtEM3gQry4njexCHekuadxdcC7oBygMoaW8
   DS4PlZzixHhGWBJNQSUAX2QxiYNx66I7Qdg5tjcXR06PBhpJYL3K/nbch
   J/R+TlETIA3wJacItBWCJtmCyhbncYTk8BpfTFqODrvcR1GSFI+0S7SrH
   JBTv4cpwJ/Pb0ZCML21eYrh5pzWAiCPG0jYdCe2xndP3ILPg6aYXBYBb+
   w==;
X-IronPort-AV: E=Sophos;i="5.85,272,1624291200"; 
   d="scan'208";a="179827817"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2021 20:36:01 +0800
IronPort-SDR: AtFDoXvGzq3PgWaxhpJNi8os50xY1/FEeo/lV5ywzqiAlC4YUV/iQIDeDVXatUOqslJizKlS8b
 q4URx4u6kWEj0XiBYuQKf0pJu+MK09STcwqCxQIsuzR6vsJ6V6jTMknnqHhM6huhsnus5y8m6O
 ZFCwgsmAgXywHGLsDzTq9o4RPdP0+hgrjC82rdDFfhkg2UAJgG5jEMRSJsmj06zCPNTs/9dkfq
 or0jE85tw/xlRWnYEa1gjrOfaff/9M8uMkzFtpw5ZjEYC40wKtr78TlWlNksNKId+d5+9BkorQ
 8rVM6/MsMziMXxHn0objVsaz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 05:12:40 -0700
IronPort-SDR: lMNWe6IoJ0G48H9detkC/Ot3VVcG3Y8fjb/y8CpUMuPU9pANE1mO9dw5u1PjPq2gf8Uh3Y9kLY
 Q6H+ofy2N3H+psiMnCzHSoqOSuS+j1eyhIdkvJ+UBhkG3dKgGmuuK+n2eFA6NHh8kghdfCP9K/
 tx2nQpOblXU+fRO//T08u1rGJO/Ywz80zsGClaa/sRxV4FpVwQa47l3yCspvNOxBb16qnJGTSW
 in5QNQWcveeYJohXENg01Zwz6HRwsiC1jFOyt4Smkq1M6xx/LBWg3C9s/CWo4SFwD/OXBDu9k7
 2IU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2021 05:36:00 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/1] drivers/mcb update for 5.16
Date:   Mon,  6 Sep 2021 21:35:47 +0900
Message-Id: <cover.1630931319.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a patch from Dan for mcb that was originally intented to go into 5.14.
Back then you've asked me to tag it for stable and resend, which I forgot to
do.

As this driver has only very small user base I think queueing it for 5.16 is
ok, but if you can get it into 5.15 it'll be even better.

Thansk a lot and sorry for forgetting it Dan.

Byte,
	Johannes

Dan Carpenter (1):
  mcb: fix error handling in mcb_alloc_bus()

 drivers/mcb/mcb-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.32.0

