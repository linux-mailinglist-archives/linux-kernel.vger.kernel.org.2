Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43B53E4025
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhHIGg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:36:29 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:49038
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233095AbhHIGg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEiUMFYIygblOAQjYTWJBMgy81T4Lw07TcsvcR7/sVJhTwtCYyw9M2hoUk2fg3dQcn2/7Q/8lDQn0hlVhoSmH+SuMuYB1en8R5dyT3F25sibEfigQEED3r5hycfab0nQ93PIgvGHQrIWMzT/B7Gam2DqyTPqJIq6U+6KC46PtEytBeOtMgYtCbeuStF3qeTYsxjp3gsogSnjKCgTlUdor5rCbpJDvA69ncrNl3yILRaV7xpYcfvySKbhfa0DAw6cDZSPpCeK2epOaMM9wprW2o5nOhBC/kylOU2QeE9fcOXhQ1SiMOCCtUuyl1rjOG+VAYyog6gdyh1sxr32Sgqpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8elKW8dWaTEX6eeUDyA2Ytt1gEz9TzElvhdV1YtjlXo=;
 b=VbbWf/XDkadYA1TJz3K5yW+a6CncAch3hBERN/e9T0dUg8p7ntLHZLfjVkvyPz9V5S3Fy55dlP0Ql7ikq5kMN5G+ESLxIwPklJvj5bvoW6/qLFpf6G5LsN+x1slHNeFzijEc7zsLmlxFZsPTWM6zjyKsEmH8Wp0iFdCKxP3Leqtamw3klWlHrHOpVRcA+Ab6ychbVhSVTMSrZXikoMgQf76NISZgtuhLwd12mvw83DR8FDIpruJLzZWXm8RMJTE93z6qfdIE6jUBZOPSdDLKSdZR6bi0kp152lvwHg3p/d6BjkTkzh11EcxPO/VF+/WEoQKfasJ+Drl7lFxSSu5gSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8elKW8dWaTEX6eeUDyA2Ytt1gEz9TzElvhdV1YtjlXo=;
 b=sHb01EBWLIEHc8WZ/mKxh0a2MJpSNp8NeF9YAq1H3SFph8J943sLVc+cs5WIls+usgWGGtGsnFVBCd/HN913VfO3sKrfRcdJu192jfGsI4gTaBk70RM7sUh7iVcGhrlzSNKAu4wAwCqtac+Ppb52KN3xWExKNK1jTG2PXqUJQ84=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 06:36:06 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:36:06 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V4 0/8] i3c: master: svc: some bug fixes and add runtime pm support
Date:   Mon,  9 Aug 2021 14:36:37 +0800
Message-Id: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:36:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3639a046-97f3-43ed-e7e7-08d95afff724
X-MS-TrafficTypeDiagnostic: AS8PR04MB7653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB765393749F966D60C37DA5A6F3F69@AS8PR04MB7653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YY7pX+1JaWZefUegxMYeRL663aYp7ekG5jESanfadsb/WVmvZNbjONzp204IaO/+o3jPYMuIwUL8+UgaLWX37Y6HIISRqEAUUhJVx5aEjekA/H6huIXmgj/NAU0UrLRw3bKwqmc8iiDwvIKdJ2InsrvbLrU1WhFynUNQZou2e0rvfs7mGfffv/csh7IYOtuIXBdjp2HXnJrsQrpHbyFoi3SxvFXEUpoHGFC7+Z2oIbJvpiVzwuhYvGjntG+zJ7n/TE+0rx0hA21poNfslzVi+puTjsLibnc4m4ss2nXs76UXLNLt0wZI4PBZh5yhHWPQOUDdHxeo3Iz3OA/qQ9eLWAugGL+CIAzWCXgpMwiYQiGXCxs6IPHWRgu5LJXr+rPllId7t5kNbJNpFkx1Ut3b/jKvL2oS8okeKErXtIIx1ANSgq7egMPlIGcWtMFK2YCYiuRGT2ADJJ0GmSNq2zTzEd8/vxKB7pYnifRVVOQ1VPbTxOVJWrbqzazXyHbhfVIhCshe82gALLKRllAa69swZmkYghB4DiScDQ5g9FhpnSHs/8MkNJUh3OSqfcm2CPH/ex+7echLJmJofxgNIVVqcKxF5Yilxux4D+Ten7PgWJ6bWLg1V45Do5iCuvaBVimfiUHECP2zrppbyRF39Y1ewK9CBSVNRv/10ZfrbM/gtxXUXInIdr1UaqUbtb6/bEOZfCltSv74UB7OGb0PdU25g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(38100700002)(38350700002)(478600001)(86362001)(36756003)(316002)(186003)(2906002)(8676002)(83380400001)(2616005)(956004)(6506007)(4326008)(26005)(52116002)(8936002)(6512007)(1076003)(5660300002)(6486002)(66476007)(66556008)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSgK12bh5zlDLSmKIAsZr1zQtdapxjsJqWWCSpZxaqW04JcRN+jhI217JhcC?=
 =?us-ascii?Q?NNq9RXr2uuwtT4xGOar4TVt7QtJ9HPg8meeDNoRe4vWQQ5gm1Uy35cWjC1iF?=
 =?us-ascii?Q?g+eS2VUoPLGgfYnoXzPVq4BajkXi0d49EsYR6IHPfA9DeZHaWRbIiOJ42a0w?=
 =?us-ascii?Q?YfFicptza8hKtbs8+22fb2IFT8tbtGFrxzoq+0e0HUbMZKaLmoPljqPEwr71?=
 =?us-ascii?Q?9IMMF5GUpB17zFu7plqTDbsJt+ZLz0iuGK30CCMhIqBY7HATUbj5mYZqN56M?=
 =?us-ascii?Q?rCE02oC+eQMdq2/Z+yaI8U7oDew1D3FwnPOQwecpM0MjzZQb1eK8K/eOnvGj?=
 =?us-ascii?Q?uPTVd3CyyzoMlc8TWBpIOIGZrS8JwSPwG+vYIHc4sbbZdQb8/zfY1rnRAYLH?=
 =?us-ascii?Q?Gtg7qTLK0wX6TmbavCjBt+zpuQ+jFIE6NWEREfAgJD3CM4OODEUDQSs2uRsZ?=
 =?us-ascii?Q?MKdknMqMBc5w6BISxjKeHei7qUBi9X2XU7oQx61rj2lI+bJAk0+dZpZf2BOu?=
 =?us-ascii?Q?PW+CbYcCcnaSTKAhYUGro9VWnStwonwyu/ZoSegrZANFnuhnlfBLs9/YQQ+u?=
 =?us-ascii?Q?ztgPUnanKrioIWABmSEn1FJ3nCw1azpGmtUXaWPO38VCoH5V/jSOX+Gke3OK?=
 =?us-ascii?Q?TPAdfGhDUPljwj8Bqq96rs+2lJzNdNgdYDEDikQ+mgh2TtEYHKbMwrVsn87U?=
 =?us-ascii?Q?VzE98T52C5IrMLKyGv8WlJfJ/I+iMMah9ndaaVVLKTRDAzSxf6HKG1HRnFFV?=
 =?us-ascii?Q?xvsmZMJmj+8WsJ5Ytx8jWamAet20Y20271kK7jtFEwT0NZwuZOEly2Ltoq4B?=
 =?us-ascii?Q?rGSR2s2cEvTgqvNWK3ci3led9WzCNbBGApddOkUvdByoaSnqzW/ST00NI24B?=
 =?us-ascii?Q?5mTDO8Q0kHde+xG0FS7y04dDVSypV9cJ5m0E5WRKEWjY2AnOvo/mtxMcSnSR?=
 =?us-ascii?Q?bJQry4akpDUF+yt3rELRNGZExeL3nqwP9zHMilMtgoXuONLbdNkBIs5JLuV7?=
 =?us-ascii?Q?R5w7k53ZQcz4dU/DpPbvL+wJOOm2bUaHj1vKIgvno5/eIA85lDMiE1n/RZjT?=
 =?us-ascii?Q?NGXjrGuvbodYn9g2rDJCQbnYfuivmIu76gQxBkb6Rsk7QiVmKDj0il8qoszn?=
 =?us-ascii?Q?3U0fF+pTOS7DaFpKy/whynArdPiHgT7dav3w9mLa3CS2tfMy3jn4qrZwkC/R?=
 =?us-ascii?Q?k86YttVfzrlGH2ot4osR1+8+Y4W4hCtFxB935KsItIx4OAEMsisaiNmON8t+?=
 =?us-ascii?Q?6wi5wW6FF2Q3178/sv+0QYrQ0GM8PoRFwm916vu1nULbtPjUwH7DjpshXwro?=
 =?us-ascii?Q?mKigWV/dgN7iyTJBww60XBSy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3639a046-97f3-43ed-e7e7-08d95afff724
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:36:06.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5KICqyMJU3ZeY2CGPaJ3gS8AijBRQm4yBVFcbiYFhKCqnvIaJkfoqLe2fSnpNHxtLrOPTbzCvBDIQunsPgO8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

V4 changes:
 - New patches:
   - i3c: master: svc: separate err, fifo and disable interrupt of reset function
   - i3c: master: svc: add the missing module device table
   - i3c: master: svc: enable the interrupt in the enable ibi function
 - i3c: master: svc: add support for slave to stop returning data
   - Only use COMPLETE flag in the read function.
   - Add a reset before each transfer.
 - i3c: master: svc: add runtime pm support
    - error path emit_stop only used in svc_i3c_master_do_daa() for one time, so
      remove it. Or it needs another goto command at the end of the function to
      skip it and to go to rpm_out.

V3 changes:
 - i3c: master: svc: add runtime pm support:
   - restore the error path of probe function
   - enable runtime pm just before i3c module reset

V2 changes:
 - align the parameters of the function in the second patch
 - add a new patch to support runtime PM.

Clark Wang (8):
  i3c: master: svc: move module reset behind clk enable
  i3c: master: svc: fix atomic issue
  i3c: master: svc: separate err, fifo and disable interrupt of reset
    function
  i3c: master: svc: add support for slave to stop returning data
  i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
  i3c: master: svc: add runtime pm support
  i3c: master: svc: add the missing module device table
  i3c: master: svc: enable the interrupt in the enable ibi function

 drivers/i3c/master/svc-i3c-master.c | 307 +++++++++++++++++++++-------
 1 file changed, 231 insertions(+), 76 deletions(-)

-- 
2.25.1

