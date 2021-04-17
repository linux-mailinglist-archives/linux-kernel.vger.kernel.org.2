Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D922362F34
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 12:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbhDQKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 06:25:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34582 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDQKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 06:25:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13HAKb26014842;
        Sat, 17 Apr 2021 10:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Sv5e1id0xmN6AnV4mguXiCqPq8KQ5QvmLZmfSk/+Hdg=;
 b=niSKvMOZ6NqJIOvccj1TipOsmfdar3kCfn3OUlHCtcyx/43aKpUHcgJdREdqperLWSEf
 jgRN7syutnZEWY1zzwOKa+ixRU+HPADE6VU2y60XdyUbsA5hYm+WKmWgUsqiDNqooeqC
 c2xGdffMFumm/2s554VNxuDJmpDSEAuP063c8nX442Qqtvk/ZB8N7Wz4mkL7US5xX7cl
 c0jkhjLglevTVq5ccfzeNLn/W6C6/hBHGBpqgxs2l/t4elf58oLPl8kDvUFHdnih1Q9t
 QCVQKMz4knxNUoJEm1gvXBfI815dgQN+SJLrwyQjaZ70XiAGuKW/bIiSuyDI/bAUAruW FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37yrap8bg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 10:24:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13HAJfpq139444;
        Sat, 17 Apr 2021 10:24:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37yq0k3p36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 10:24:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13HAOYaI016727;
        Sat, 17 Apr 2021 10:24:34 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 17 Apr 2021 03:24:34 -0700
Date:   Sat, 17 Apr 2021 13:24:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fix an error code in nand_setup_interface()
Message-ID: <20210417102426.GP6048@kadam>
References: <YHaEEYg2DUFwnxSo@mwanda>
 <20210416170040.4e467039@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416170040.4e467039@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104170071
X-Proofpoint-ORIG-GUID: rbBbbTqEYbSJNA5J3RbjxamUH4pw2Nq6
X-Proofpoint-GUID: rbBbbTqEYbSJNA5J3RbjxamUH4pw2Nq6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104170071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:00:40PM +0200, Miquel Raynal wrote:
> Hi Dan,
> 
> Dan Carpenter <dan.carpenter@oracle.com> wrote on Wed, 14 Apr 2021
> 08:56:33 +0300:
> 
> > We should return an error code if the timing mode is not acknowledged
> > by the NAND chip.
> 
> This truly is questionable (and I am not yet decided whether the answer
> should be yes or no).
> 
> Returning an error here would produce the entire boot sequence to fail,
> even though the NAND chip would work in mode 0.
> 
> Not returning an error would print the below warning (so the
> user/developer is warned) and continue the boot with the slowest
> timing interface.
> 
> Honestly I would be more in favor of letting things as they are
> because I don't think this may be considered as a buggy situation, but I
> am open to discussion.
> 

If we decided that the original code is correct then one way to silence
the warning would be to do:

	if (tmode_param[0] != chip->best_interface_config->timings.mode) {
		pr_warn("timing mode %d not acknowledged by the NAND chip\n",
 			chip->best_interface_config->timings.mode);
		ret = 0;
		goto err_reset_chip;
	}

Setting "ret = 0;" right before the goto makes the code look more
intentional to human readers as well.

regards,
dan carpenter

