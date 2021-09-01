Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34303FDE89
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbhIAPZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:25:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13690 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245738AbhIAPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:25:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181DMfAq026419;
        Wed, 1 Sep 2021 15:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8EL5l8RSyufC07TCv0G5DV0+4A/4rrjMhh80bFit390=;
 b=IuUcTidmYDeUk+l/9Z5glzNisR8yK/l0N9gVtJvcYH/sJmREdl7GUfaI3u90JngAikS/
 BSaSGrXwoTDPm3K42x/HVzvbcTfZRwU7nT1mE1C3Gc5uVCIud+C9O+OaaVMEBOiAv63n
 GcBoMNpV+XItnML8Q3Qvguj4IJnJcAMuS8+uutV8624eSqdmLF/fJMJg69Zs21Wz2RuZ
 vHb998bL70AW2Avut+XqyY9tmWq9cNt+r8CHOCoGEJBcfxpvL5RHrmXmM20L1N2x/t46
 1I8ShMYpdLfDXonyD8xWMp5M5r1Ll0drJnvLMT8XmrqbnF4p3QgB0A05FhSxdai7AIsA fg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=8EL5l8RSyufC07TCv0G5DV0+4A/4rrjMhh80bFit390=;
 b=jwZOri8AmngvGGcLUzuDTToxmG5QeCreQoaAjGdGj+uh6HYHUviJY2l+V9y/nBztK6QE
 3i469A47IoQZCO/nHPKiVPaFpag0gF8d7w/mTC9PjsiMn8ZN+O5TxvXtABCl4iqMymsu
 riMJiSBYsbXArpGX0ZZmE8y1nf04yu2sjklL+mp60UBDRnKMLQFs1fjVnjsqkpa6tAc6
 nyA81mMgBkxF/4maR2kuP927/5CQRfnuaI6O1Mnz8XYgL3lD9X7BLn14BH1IsQ4xAWMM
 DN02aQmTQ7qp/3YRklpumy62Wxa6bhx4mFVh3g5392tT2S90LB73WcMdy9BNHzT4m5lx ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf66n1ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 15:24:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181FFtXK034043;
        Wed, 1 Sep 2021 15:24:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 3aqxwvrv8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 15:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZRWEgd117OPMbP+xZVia7qrmMQnX07U4hIF/di4S+jdVQklVnYHB8AIwNIAMwTJdPEFMoXHVw+o70J2pQfSdjbJ0QgIawdr2OcM13drF4vcuamRwcEY9m3x8sPzBY577+GO8c6gyi868nFITHCgB1R91fXxVl2ebAPhbZM1wK+ilyLDm9s1EATdOjzDyModmT0eVXs+4d+ojEsrpop0UHrL/4im0LS3qZITZ64anmdvltkwFYgmFTq7n8FC2Z8l/rgEDaM6J9jPCkm1EWYEnFwRCT7KgojlWd+Ee+sjHraPs+/QL46gI76S6+rSk6+d4MFcEYadWf+oIDzfTzP6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EL5l8RSyufC07TCv0G5DV0+4A/4rrjMhh80bFit390=;
 b=HL3JSVUe6+UK8bIty5lEap9qwmtfUn9/reEvYpE9bcux91qSfwnQH8HC7bwBBKUFzk+4pUsFd+QsH2Gu6sEYp2XEZoI4XRbdMiQ7g4gSOKyOdg00GBHWU7NxO0QKfKrEXXI38iYjRI+wL6HafBjUGyucPKpzfE1u6eIR58sCXXSYFtr+vKtQw+01jxVRign7TdAsg868c3fLdEOwiA19c8DnalgXDiV/jhUEBH1wm/6AZSpSdZSpTyUc1FkWbF+ZqaJki/2dNYc/UO504cZ/u+3kAC9mksjSKeHP8CzGFcnnPgVM5ov0autk7OqXiyN6CMIofEp8ep7o+tPOlZJDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EL5l8RSyufC07TCv0G5DV0+4A/4rrjMhh80bFit390=;
 b=Uoj4cAPZXZ8boH12LF/CYC/BjBrRnbcGjPBRk/ut/eDUuiionPnaGQB8vxyAdXx7DQ9Yeb2uk2yVFchpX3kJBpHo4LaleRAzzK28MAck5AIT1em3lOEcB7nwzzvXqtpAPfXc6wFsEn5SD2JXW4EwUsNYp7FF4rcEihXrZHAwyFs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5569.namprd10.prod.outlook.com
 (2603:10b6:303:144::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 15:24:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 15:24:06 +0000
Date:   Wed, 1 Sep 2021 18:23:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     smatch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Harshvardhan Jha <harshvardhanjha1@gmail.com>
Subject: Smatch v1.72 released
Message-ID: <20210901152349.GC2151@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 15:24:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18165426-da49-4bb5-b8a8-08d96d5c894d
X-MS-TrafficTypeDiagnostic: CO6PR10MB5569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB55695D79B0D98E069E0E55CE8ECD9@CO6PR10MB5569.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnmGGGeP5ErnWUp8CimoSBhnMJE6vhtaVKp1HgK+spd/REUaQRCd5r3+kDhZuNvN4LSet3wX+ZxC+cpWOvMhIrJbxcDQKJfnR8mHFdUMTCdwzzCxQAQkkqibnBXpP9Y5R2t9ud79d5gvQ2BNbRc3QcWFN/CFzB3KOkeDC+uZLaA7S9CLP+PANmxMEgfpA72Pcu/fzKDicDLqfOHHzqBYdLZbaUtx2wnIp+l3xlYa4+XNDeByWzjyk3Acn82WtCpejB1+DjUxwT7v9Nu1Sjy3usZZ4mkLp89+eGZrytY8C32J8eyVVdG9ieir/NsVCCt/vIhQJwcDcAikX7AYQwgCHj2CRLuq8n4TRuIMdAyGYvo/5EVNvpVSPqIcVP9YnD6HM8Fclfbo6tEPUxqSWK93GNYpzYvZg0uLW0Zn7ShUDC/l2oWG7/VQAHwf/uK+JHTUL0zR0VA15HM09IqluvYzHtqT9FrcP/KhgWGEPgb9//LnWSmWNc4pvJ1/CGVsGkp4IH5UAvCgjmTkqo7t8MfiqHXRu4n596NLg9H4IZ86SQYG/w973P3nHTzFAeKKRka1sOMWlij/UTzEiXLCZBaVpgBoCdti2thoBYZaPp0y0Ythrf3uDeBcZW5CQwjUZpqE/ihvF5OT9C/LlZfiasZTiauQhfSH32B3KArP+PQnezVYLLLg0ta+bEQ2fGojjg6knAwU3RmMIOW3gvnOLMEKMovCxiJe6KweU+rHtk61welQXfCJ0JMKMtTPkmQYh6vjBOXNhmE76iVyNTNBisy+AI1oxo3Orr6MpsoY96P3jPuCSloQw5T21y0V2LgsJ5SbBfPVkQXBOLlHuLvEsBLRfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(6916009)(478600001)(66946007)(33656002)(1076003)(966005)(4326008)(66476007)(66556008)(5660300002)(86362001)(2906002)(6666004)(186003)(83380400001)(956004)(44832011)(9576002)(38350700002)(38100700002)(9686003)(55016002)(54906003)(316002)(8936002)(26005)(8676002)(33716001)(6496006)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQdrV/3m6ox2OWLgZX8R15IZF0iWgSnvDTraaFIaHGpGGC0sWiMMf4zpH3X8?=
 =?us-ascii?Q?+ZanGGCsVRM/jn5grE4TC4bYx+kVsDgCswfSqfwLNJDPkAzk1QRUbDV8F5ZV?=
 =?us-ascii?Q?xakf09BQBFmQ7JErxK6/6fTJpyH77eTacFLLGw1JihaB+T2BR2HMfJrX1/bP?=
 =?us-ascii?Q?V6hv4q+OtJSDDLHvu7fW0VFcTM55RFy3ZgFbwsF/2cDr3h+gdFPs25VF16Tj?=
 =?us-ascii?Q?zogYyL1ULqdCW8QACbbl0kcN+YYI2fDoS77XJcSaw3kLdozQm3wMxXz1eEFT?=
 =?us-ascii?Q?EIQs72kcmJsjzi2XaKJWRn4wpduXASu4Ovrq1KhqLRdJVnONalcKTHJJAfTH?=
 =?us-ascii?Q?Kqlbf0o2jZahloag0WYASkH7T2h7PqxAEsiMvVBtlC60ChIN+e0QEdkUGL87?=
 =?us-ascii?Q?ynsPHvdbSp0UgJPSpIseH3zkZlz/IMM4jYcEU4SBoxNTvmy5qQw6s0QKYtJ5?=
 =?us-ascii?Q?wEnzPX/FAirSikfQ4L1idBXNXii+1+aNg1xcftN9QIxL16v/+AAtROtHn1KT?=
 =?us-ascii?Q?sq6b+wYxeP4ePU4YKKyBM0u9HDBdss8FLs45fJ4FkhJ5Zajhnkwk7Pw/A5q+?=
 =?us-ascii?Q?SfcZ8rmCpJ7Us+0E22eHN5VPcytJITUTEKh1xeGtWXty6WhxMFvCGGKvGoaM?=
 =?us-ascii?Q?ZldX9hbTjTYIBlIjse82MeJouj9kvFtSyzq8onrgdjQOshuw0CNJowppoL5S?=
 =?us-ascii?Q?OFrCu54fCyeFP0R++RBleywz3p60MW8m9fnbB8rk9nWqt0c2/VfUMjPGxJ+s?=
 =?us-ascii?Q?h3cEqifP/TQAUY+kT1B4/LpeuHoVL6gZGFgfi1AjbxEUcvWdSyU6q42PY2A4?=
 =?us-ascii?Q?dFT42nxESkfzP70ij+zFlPbuWzTR778w4dEd3IzwFiGuSlAQSh3rn21sQ+VP?=
 =?us-ascii?Q?k1CeYcGyxv0BcFWOBlrqXf56opRjpq4qOViNX0IyUwGNYiagxAsMqu9JFmP/?=
 =?us-ascii?Q?YzP9qYatU+wZTmhMN2NDWGYr+0CcqZ78j2eivHBsE1WLtflocU7nZMNv80r9?=
 =?us-ascii?Q?YkKW3U17G8gwwH0aFWGk94lnFBTrokc0O9c0Kgu1NueMc/uG7kZvgi90GFSQ?=
 =?us-ascii?Q?JoD9UVQkfzufJVHkSeV2wFiL9n9qdxeVp7LdCWcaA8qeVT15rzjeoX38k3vA?=
 =?us-ascii?Q?kDDacmBIBVmKlk6GtaMrzuK7wu4nprjCusP7L8yc7N1pif2OszknbOKH2+Bg?=
 =?us-ascii?Q?A/pImgKkM1R9D7nZmDcw5Ij/tqmu3obwXi/4FdoNI4CrMmCezWZBxLWsJlwa?=
 =?us-ascii?Q?G+gK103ZgmIsuIPdkuuBCWEYR+INR/F6hnKLkUihx8vwYvNg+hBPjgcryP/Y?=
 =?us-ascii?Q?znsLQIHOa7zGFlYCO1+md31b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18165426-da49-4bb5-b8a8-08d96d5c894d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 15:24:06.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lfg9qAHN1y5KZq85rGRydgXJLIsylnULY8hkFjPFvwgbo12MxoBR1tUZVf6S9LpGC4HZ27j13hthwa1wKU/d1enMTZ8n98AGdS2Sm30YB9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=710 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010089
X-Proofpoint-GUID: rIsmKDfp-em_wc9I3FzPR3vA98Q076fS
X-Proofpoint-ORIG-GUID: rIsmKDfp-em_wc9I3FzPR3vA98Q076fS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch is a C static checker with a lot of kernel specific checks.  You
can download it from:  http://repo.or.cz/w/smatch.git.  Or if you prefer
a github mirror, then you can download it from
https://github.com/error27/smatch  I'm trying to do more regular
releases (two per year).

Special shout out to Pavel Skripkin who wrote a check for use after
frees releated to free_netdev() and to Harshvardhan Jha who wrote some
new code and fixes for how Smatch handles bit tests.

With this release, internally the param/key API has been fleshed out and
improved. The check_unwind.c is an example of that where the
return_param_release() is used by hard coded data in the func_table[]
array and it is also used by the DB.  It just removes a lot of boiler
plate code and it makes working with the database easier.

The other thing that's new is the SSA module which is also used in
check_unwind.c.  It's so that if you have:

	ret = alloc();
	if (IS_ERR(ret))
		return;
	p->foo = ret;

Now if you "p->foo" that's the same as freeing "ret".  The param/key API
and the SSA module are going to be important going forward and I'll
probably end up re-writing a lot of code to take advantage of them.

The exciting new check in this release is the scheduling in atomic
check.  It requires the cross function DB to be useful.  And the
warnings that it prints require cross function analysis to understand.

net/sctp/socket.c:480 sctp_send_asconf() warn: sleeping in atomic context

The line 480 calls sctp_primitive_ASCONF() which uses a GFP_KERNEL flag
so presumably it sleeps.  Use the `smatch_data/db/smdb.py preempt`
command to print the call tree and find out where the spin lock is held.

$ smdb.py preempt sctp_send_asconf
sctp_addr_wq_timeout_handler() <- disables preempt
-> sctp_asconf_mgmt()
   -> sctp_send_asconf_add_ip()
sctp_asconf_mgmt() <duplicate>
-> sctp_send_asconf_del_ip()
      -> sctp_send_asconf()
$ 

When the call tree is so long like this there is a lot of chance for
false positives but really it's surprising how high quality these
warnings are.

Please test and let me know if you find any issues!

regards,
dan carpenter

