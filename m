Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBBB3BBA83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhGEJyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:54:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43872 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230000AbhGEJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:54:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1659fsT6025822;
        Mon, 5 Jul 2021 09:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=xuepNNlVL7TEOzjtlGa4WBrbCJiCNANHgf2kKHid0Gk=;
 b=lCJY/e688FaCrHcZhZi/mnuoln2rMslmiUW2dQTPROJvxVFUw6aoVwkyZZUq3ULsWJWA
 e39iIn75gb3CxYQSOZ+/jFalEsCOX6NUS0hYUq0ZHUNBdieq3bczzayETgMLUtlonjMJ
 ktoPtRsn6jTfvzCDeupyBa0v4124ca7I+hWEG9urBZTHcdOwINILRAAtxbPH+70wCTNO
 E8PEuVyqzC9AN++5UmaTRebcu0Gkb3MdfV7+ileXUC1U+Dm5QEuVHpUHLhCTP3tWwp8B
 uS2Rp7OnkI0FmwNiU7ijZdj+oK/CHdB6M8q2q9d+A8rehMEdYWWsRCHRjG+a5r87W7l9 WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jgesa6y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 09:51:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1659oPLW050153;
        Mon, 5 Jul 2021 09:51:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3020.oracle.com with ESMTP id 39k1nsw7va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 09:51:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNc3bzRPOX8OIL9ssEejYNfkpw7L0t0OBLnk/E6VxTRYDccYO43dE0cyUJLwA8KqhTLIIiXHn2BT+ALf2k6fU2kL8wz5VM+62qYNJ3hCkGo2Mj6PASCfAfzJ6dkcEDP9EeBUAXd9u3cPcNs2ZhFX3+nJsMhRPe2Zku51p5mr+3DlE7/T/8a6aZ26KVhgHK4Pe4/XbUtQOwq6iLxS999XwQDTKmm274uiWXbaqKTvzwtoay8E9r54oJI7vUy9BvSVnHs0HTAaH782wnHLTh1UULC+Z++sBX7jGpjNwIAdTKw9nI2olhnU34ZOB6hDqeRuXXZTfWPpTKLXH9e6pXEg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuepNNlVL7TEOzjtlGa4WBrbCJiCNANHgf2kKHid0Gk=;
 b=cGojtWt9tviVuaty9eqZgjw1QlpSiXCqwDIwJ9TjVPSuJaV8BxRsoWN4KwBgr1wrl6/63IkRtAS/ms63lLVmWwdzgJKB/4ytGPjpfXXCPela7xqibdj6wIxtWuFtgM7UghltVOZnPjnhLcPFBlrpeblM58YUevEd0j2D9APiVF87KMKpp+PIRg8bDRtXFwviHbDRSKpQBOyoxVp1IivRTB3XxD5q1pNNj7WHCdHnY069uIg+fr9mG0tfOJUm8H57KUrXHOP8GlIU3PCVTbVLn/6RXm1vUMjhlYQALdUcR/uSdU9wT8N9csgu78H+zErVrfj98OVn4X9ydAk4pXsHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuepNNlVL7TEOzjtlGa4WBrbCJiCNANHgf2kKHid0Gk=;
 b=wENbFPu4G30AkPl6FSoyWLIIDIQFHL+ni8i3jLSTC66KxTc57wQ9Ca8+57Nqp0/ZkYbS4cw7PhfTHOPU/2+ZzB4flkzSUXH9lT3sJjn/nkoCAb+LYgFAwaDJ9ff04IXJQysMpJU6bFtQMH7cLp8i0wG66OIXSblTJh9fxEv1vAk=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1613.namprd10.prod.outlook.com
 (2603:10b6:301:a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 09:51:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 09:51:22 +0000
Date:   Mon, 5 Jul 2021 12:51:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Zhenguo Zhao <zhenguo6858@gmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: n_gsm: delete DISC command frame as requester
Message-ID: <202107051434.YLkPvgff-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625452087-12655-1-git-send-email-zhenguo6858@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Mon, 5 Jul 2021 09:51:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0406639-b101-4e24-56ca-08d93f9a71a5
X-MS-TrafficTypeDiagnostic: MWHPR10MB1613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1613E3ACA7F9818EF346A6FC8E1C9@MWHPR10MB1613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +z2zflhfRwVIMSob1rQcPjw31AR8wcbvugudwkXjGqQp7kUNLQaCRbD+MOaG+rIzFLpfpaftUU4f0Pb6g9vG9KOkW8DGazIr7G116lAbmJG0edkcivaRdZ7uwZaIUXKUkhMIL9v7fCpEKeQOzdKPP+8z0GwGGqPx69+BVhUHYSSHcKzski0L0wTMCOKPnnWcJA5brfQlDuNGHLxDNxs4vIe+cK+C3+NfDLp8KifKSoVnn1m4On8cHAhkrGeEgEF4L7edx/G2p2OueLkLZysLpxx8xfraejviQDBGGIDeR14aFV9J8latTjE+jUXG8/Q9P1Qrg7+0bnApHPyHAGdLXn0QpCx522I6zutx4N+viBYVSHXXpfS0BtLTEM1yMWH7x8iPQJruo/TJQQ8VmzhB1dJQjWUjuYfamz4vwFPWOiTOUEF0FsChh0iZM/Se9iPnEeSY6aPfiEPKGY9xWaoX40xYsQZy+Ns8cSbwrXbM8XpJGmR3xKZduJd9tts54iAj9lQoi+lUgqHgbGBvTob+qieO8CTqRtp1XFyCjKhYOQ8ov2lrr2ycdqIejvi7E+ATnEMZqkU9NMeS2Ii+BxydJ+kan4P8u3R3Gdiwd7Q5hmRKLsI0ieViaLllg8VM2snn1N0O3VF477uVNEVikr9p6JBltNPGh7p2eDl7Ks3wNItXop+Q+/ghzg4yLZUjKepfqIRSpSQKYxy5apWqJHPrFlsh2yOytPve2rh3sijTooIo3qoZE52S7D4Lmg0NcC27okNxCmb+ACKI81v08MdYDCw+Z0+gKEJcOIaheD9nxQH6KzJ4ikhgPLQmuiSjfD03
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(66946007)(966005)(38100700002)(478600001)(36756003)(6666004)(38350700002)(9686003)(26005)(5660300002)(2906002)(6486002)(16526019)(186003)(66556008)(66476007)(1076003)(52116002)(4001150100001)(44832011)(6496006)(4326008)(86362001)(8676002)(956004)(83380400001)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oCpZ9PfwhAc71zj78rl8aaugrJEEl5AEZHBLEHPZ5/8BjvdxdemgpbUQN/Tb?=
 =?us-ascii?Q?lyRPsQ1V5uzoOIhhwTzq1DMDKmm3dHH5TBQD62yh150saYZR2RHce9uvKt38?=
 =?us-ascii?Q?RfGOTVbGLXfQ6QvWVfDF9oe4V/MJ8O0oJA2KwQXNofGovSN2/wOyw4OfmZMZ?=
 =?us-ascii?Q?7UhnAIaPo1wKY2oVPZzUbbwW+Xx058nEHIn32ClENFvHJjhdCeyd0d/5iQed?=
 =?us-ascii?Q?Y9pEOuBB2owC+4PHA/ggdR68JrqZ96lNU0NZQXYIARFLa+2VahE7WPgZZwUu?=
 =?us-ascii?Q?MCHJ6rhlR2xlDAU0TSMmG097/aBgsEsLCmUqO1PBrsdPEytGgi8ka7OEk8p4?=
 =?us-ascii?Q?uJqPo6pYssHbd2wMLzO53Fb+t+a33aJcwR1LlCVj01GP/sKXjBlmOPQpA6KS?=
 =?us-ascii?Q?nRyTkG89jUI6k4axTnGHDX1Ft1LtY2ABgMRarnKGmUkqtNpG7nuxywrUgAE3?=
 =?us-ascii?Q?7tSwgO3PZwXUB+SamjtBlWG+vmaP908TOOimCyTdIU0vB0J99ORcileCT1Ty?=
 =?us-ascii?Q?ezOpOBdGostyWIE9AumRN9+58DIiqru0Lz9wkrr34kLqMExyhfAXYpU+hvDS?=
 =?us-ascii?Q?uNampq8FMkBrRm5M0CWObm9NyV3JRgLB5QTzNenUFa1piz2l0BUjXv7wOneM?=
 =?us-ascii?Q?wV8WRu4bz07CpYo/NbhlHwA44bB0Wr6RAMKESIY7peUqbLELIZ4SZsBUw4Rq?=
 =?us-ascii?Q?jN24aEDh2w6zP8riyAWmQhStJC3tPW05AWHzlPBWexMfvfJSjVvlcHw4ZP4d?=
 =?us-ascii?Q?9jt4YvS6R/oPwTzjZBQct66wfwt6kOQDQ1us+oicXrmOsYbZH6FX++8FNm5L?=
 =?us-ascii?Q?FSpY/DZ4isjWz0+ulnDL621CEPs6FvOiWq6ZlXTRLZlU+ei3CTwTwZtj7/Ls?=
 =?us-ascii?Q?ym9A1rnjjvY5CVoQcLcEAsCDvNedm54rqY7mTfqBtQ4pS9M/H418edBeZiNX?=
 =?us-ascii?Q?83xPvjAgxWGAdvYheWt3qEKbhyb6LpCgfxokuSkTXnrfy2JoVTeG6qqQDhIL?=
 =?us-ascii?Q?VTjc7sqAKso+iMYTeuXjPNEp35UZm0Jcb4OunqITSKXpZaG67xMF+CzShUaD?=
 =?us-ascii?Q?FfO0ZPSJy9ioKFMSwUFgZuaxrWwz69griURaavXrnudvUauVo3HqBjhjF80s?=
 =?us-ascii?Q?MZTP0NniVc8cpV8kUc7FOS9jpRncP+Pd1Fa18HSJs2/kNzXsgXzGBtdkGpkk?=
 =?us-ascii?Q?9JaeaFUCpFR56XU9hE4YQiayeT7/UBTOEIAgiQKY4prtyPogJpf5JwTt+DGw?=
 =?us-ascii?Q?ZJPg/gWHxxEY1gQL8Kg954EZMAemwP5xpXlT2+tVLsPuMDIzMJSlmIxuQpPm?=
 =?us-ascii?Q?emlvzxf/tr2xaK8NUdosM43z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0406639-b101-4e24-56ca-08d93f9a71a5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 09:51:21.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYFkG+6AfgS/Bvo0ZLgz8y0WJK+DtEM4IEEcYkxE0+ACf8eEt9FqwVejXPqt44lDVF0TnKKecIW/svEq9s1UWAMwwfbMIVOHpWyouVOs1KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050052
X-Proofpoint-ORIG-GUID: XREa6qDoUpZd_9mRLHKN5MedydZLo9XR
X-Proofpoint-GUID: XREa6qDoUpZd_9mRLHKN5MedydZLo9XR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenguo,

url:    https://github.com/0day-ci/linux/commits/Zhenguo-Zhao/tty-n_gsm-delete-DISC-command-frame-as-requester/20210705-102943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: openrisc-randconfig-m031-20210705 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/tty/n_gsm.c:3023 gsmtty_close() warn: variable dereferenced before check 'dlci' (see line 3021)

vim +/dlci +3023 drivers/tty/n_gsm.c

e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3018  static void gsmtty_close(struct tty_struct *tty, struct file *filp)
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3019  {
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3020  	struct gsm_dlci *dlci = tty->driver_data;
f72c4013b314ba drivers/tty/n_gsm.c  Zhenguo Zhao    2021-07-05 @3021  	struct gsm_mux *gsm = dlci->gsm;
                                                                                              ^^^^^^^^^^
Dereferenced

6ab8fba7fcb012 drivers/tty/n_gsm.c  Russ Gorby      2011-06-16  3022  
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26 @3023  	if (dlci == NULL)
                                                                            ^^^^^^^^^^^^
Check is too late

e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3024  		return;
4d9b109060f690 drivers/tty/n_gsm.c  Dirkjan Bussink 2013-01-30  3025  	if (dlci->state == DLCI_CLOSED)
4d9b109060f690 drivers/tty/n_gsm.c  Dirkjan Bussink 2013-01-30  3026  		return;
bcd5abe28f40cc drivers/tty/n_gsm.c  Russ Gorby      2011-06-16  3027  	mutex_lock(&dlci->mutex);
bcd5abe28f40cc drivers/tty/n_gsm.c  Russ Gorby      2011-06-16  3028  	gsm_destroy_network(dlci);
bcd5abe28f40cc drivers/tty/n_gsm.c  Russ Gorby      2011-06-16  3029  	mutex_unlock(&dlci->mutex);
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3030  	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
dfabf7ffa30585 drivers/tty/n_gsm.c  Chao Bi         2013-11-26  3031  		return;
f72c4013b314ba drivers/tty/n_gsm.c  Zhenguo Zhao    2021-07-05  3032  	if (gsm->initiator)
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3033  		gsm_dlci_begin_close(dlci);
d41861ca19c9e9 drivers/tty/n_gsm.c  Peter Hurley    2016-04-09  3034  	if (tty_port_initialized(&dlci->port) && C_HUPCL(tty))
957dacaee56d18 drivers/tty/n_gsm.c  Johan Hovold    2013-03-07  3035  		tty_port_lower_dtr_rts(&dlci->port);
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3036  	tty_port_close_end(&dlci->port, tty);
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3037  	tty_port_tty_set(&dlci->port, NULL);
dfabf7ffa30585 drivers/tty/n_gsm.c  Chao Bi         2013-11-26  3038  	return;
e1eaea46bb4020 drivers/char/n_gsm.c Alan Cox        2010-03-26  3039  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

