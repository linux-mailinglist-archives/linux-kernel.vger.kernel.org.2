Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34C64504A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 13:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhKOMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 07:45:52 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:10420 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231375AbhKOMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 07:45:44 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AF7YtLX004622;
        Mon, 15 Nov 2021 06:42:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=klCpXSSZcIP5qBOiDyPDjx6ZzQvL5Ruf69JbD5uSlcw=;
 b=CrmwxIugYy3JUdEJryW5OK094USS//eBpgLXWFVRa8SU+qDZ0s/wllTZG8DSQRbXAJsW
 5wu+b3w5p3io6keKqo2gfDJhOA+dKGSydntwrMA+pbC9ooR9UqbOz/HrXtAOSxxw2J4L
 jqm++FqwTEP6vTtDzBAfcAKBSRTJw5rOrxHSYOPNeYG2EpYVuMx/aq5yZ6vNtS7l/2qY
 kxplvsOgQF9nPrtxpbt7T2EaL6aIidzE6v5Q9xcRteKW9CN6VwS2DPUNSGSrbGmJf5rs
 04wzKBtBQqr3kptsoFcLV7fE8KeHhPrmfCgkn8ZdNFFFb40SXOJU/7rqLcYwwCY1YlHY gg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cbjn009at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Nov 2021 06:42:42 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 12:42:40 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 15 Nov 2021 12:42:40 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 14F1FB2F;
        Mon, 15 Nov 2021 12:42:39 +0000 (UTC)
Date:   Mon, 15 Nov 2021 12:42:39 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Simon Trimmer <simont@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ASoC: wm_adsp: wm_adsp_control_add() error:
 uninitialized symbol 'ret'
Message-ID: <20211115124239.GA18506@ediswmail.ad.cirrus.com>
References: <20211115120154.56782-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211115120154.56782-1-simont@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: UE8Ucr8CbSSxKgU-vQvkbjP9uMiZu-Qn
X-Proofpoint-ORIG-GUID: UE8Ucr8CbSSxKgU-vQvkbjP9uMiZu-Qn
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 12:01:54PM +0000, Simon Trimmer wrote:
> This patch fixes the static analysis warning as it is correctly
> indicating a possible code path, it cannot know that for the affected
> firmware versions subname would always be NULL.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
