Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385123EA40D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhHLLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:52:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13424 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237040AbhHLLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:52:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CBospD009873;
        Thu, 12 Aug 2021 11:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4a3izzjWqtTFQsIpYGxjirHMDIVxmt/vS2wZEi6pCKM=;
 b=qVT7WJuO/eZpSLBGOpRDv6CcLX63wfYJiXFoUND1THZU04mWk3rVd1J3KEP4mtSremAs
 nfVGzUnb5ljE7es8sqqGNnB1yzbW3YlOvMHrqcevWIamCiTixAOy5PPsORtVwTLseZeM
 rkG6OBD0LuNrVBIrNtp0eGDCaFvAQcJakcN5fx99rDsccKGg3d6F071d7bRFyFnf+7yC
 Sq65jHyZobqYYDQaE8sNNMSv8de1GREDqcrDHZBjlawrFnsn/C+yyzput8ADAKj5nhAJ
 yE2UyeKQqWEacbAEj93g/wE7fY/0Sx0ptKynyZMoeRJPH7coxaOYLo8z/3mgYf3gknTK 3A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=4a3izzjWqtTFQsIpYGxjirHMDIVxmt/vS2wZEi6pCKM=;
 b=KA56YK0mfnpRWa/ehEhbN47wIkQkN6IXhP4Xv6Pc6SS0g/ggF8rFbJ1ZZC264KnQe2vv
 lni5i/XDPEtjfIWjktpCFgyv781dKXAsI0RU8uENXAe7kNRu2qctuVtdYmcbqNncboys
 7prshIT9W3uF+Y/RDJtLyWLGvB3ZxsD4LGSGF+HGR9S5fXuC4Gp8jvoAZTzBGZRkw9sA
 n4JScAli8qKI1+Q1GG0ZixTjoldSmeS8JFaRwKg92QAMUq3nR8hgDWPk6gugP8l3UNph
 qdE0jXeRlO7a2z7QRck12PrWnaA6K/NYj/41UX9LAOCf12SF67BzJSd9ARe+/3YffU64 BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acw9p0qtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 11:51:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17CBkFAt106001;
        Thu, 12 Aug 2021 11:51:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by userp3030.oracle.com with ESMTP id 3abjw8ed2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 11:51:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/oON2om9/p1vNzX8EwnkE/I+RNrMQ06D5jO1rHOWgzp3+yiartptafRAq+GM+35KMJVryMB/lFnDog96Dk4g0AODYOWzEeWtb3tjSTJoeMMDGHPQUOks1usDPaOT6g57BDBhLo3bGwTTAXcsx/Tz4Rxo9/q8CtvH9KhlcTm+yxYBO38UZwkYRU9GGHNf4gBuyOpdtnSa5J4jhP6NivfiQF6431DLrwJiRypp138oTw0OyAgD9IfPDpYMCbBvBcPatdu38lT9OAjtosZO/ONtAQlu032IzvsPQ1qN90XOKFczC3YimUVEmaxgt0KmEoKSs+ngRR9VDPGyeKhYJNYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a3izzjWqtTFQsIpYGxjirHMDIVxmt/vS2wZEi6pCKM=;
 b=Qlco+7LHcUnaPk4oJI9SfHJwANzSWvc3gzrgkGxAXgQ5XCEjjFJdCSkyuFNDsNB3kXZYm1Xn5mQmVZ1imTye55EXzpvOXFgglOC0eQzB0eUO3qG/OX5hBR2BVorFiJrMm+HTxh0+RmDkR2twYMQCqr4dnzWskkJ3q9D2OJt3TaNyRK4xkUFvgQQbOHdF3w5Q3/kmWLP7KgwmEhTnsEgqzLuGaKVCgJZum6Dzp2IA/Wy33gPhEky9MHd7GTi9HAawmTzrurOl2jfXZpJFClmMYlnqOsN4yoCHLPCvVRmTXey1kTFrBKO0VZf1ReHt3C08PsqzInBrpOtSnoJ4uE3NJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a3izzjWqtTFQsIpYGxjirHMDIVxmt/vS2wZEi6pCKM=;
 b=Xn2HpSiTs9RbnnW1dtvJommtBPeTd1kAfZMU5xntuK+400KMMPU9g6FDad2NdZsT91dVIRGrEpiUXR3/y5NaZLEV3LUl8yiL6kNAaJUrQFYj4dH9MWlGCk1RSKH5ZswFgQPkBP8LoA9apOgldzzB9WGFEz4r8MO1BUq3Cs5Xef0=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2096.namprd10.prod.outlook.com
 (2603:10b6:301:2c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 11:51:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.016; Thu, 12 Aug 2021
 11:51:23 +0000
Date:   Thu, 12 Aug 2021 14:51:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Thomas Zimmermann <tzimmermann@suse.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] [drm-drm-misc:drm-misc-next 10/24]
 drivers/gpu/drm/mgag200/mgag200_pll.c:142 mgag200_pixpll_compute_g200se_00()
 error: uninitialized symbol 'delta'.
Message-ID: <202108121820.0bO8dsT7-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: HGROG43O2JWMLXI5GCH2CMAMIPCF7N5Y
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JN2P275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Thu, 12 Aug 2021 11:51:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 584361e7-6ba9-4b88-d1a6-08d95d878215
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2096F9A9FCE83BE17212665F8EF99@MWHPR1001MB2096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mejfsKn756D9QV+ogV6OLH3sNMBkO74iiEPZjlwg60dfXZO+oAp5enNuc97OGZm6H+k0V8ND1rVmRf2aqZJG5rNUWT1/5Uy1YVBlAagbPC2511LNcSM7OeEoTgXMOdwQ4Lbr678x47Sg7JOtmzVRQmDk4Py/mTpkKagBX52G7qceRznAr/GtTn9ooWM7Ig3g23pWCzf+Pz2CFhJak7fSVdVMrL3f/rUngJXFvVD779BXFbXJQaM8ftQGVh8s52tnE3pmVqJxTHizSn13f6lZ241beL6rvDubYikBvdFtiozi5M7Gh5WS6eczQBlEVwaZxBvQ1NCOxEc4E72iAUAS47ChULf92erKSFGEtCF/RjjgT4GZTxa4e+Zq6dARzIgEpTywdmStchK/jV7R4qXKkPNBNoLQtcBrzAXy5avISmuu/bLUf7oMW0qeWrdpgSaE2BHkPe4B3KAio0SfEj7ozzUv67p9YucpSrjikjdGRYTecQd9svqATH8F51MPLUGwgjXSAodxul0xhmR5anYMtb3wbFvi6Cu6jMeC/8ZrZqCBjm3RqEUBvgl4Nr1Lnw0n6+v2Zmqapr94iDt0Bj3TKSySe/bGPS9hn5oXqI7tcilbI4N27QLwuvWvXOM8ovgQkM+80az2mGmkXHbQL1heBBb1+WvJk+r6FUsfO84n+ppyRsyyoy5Z6aLTdHevvjr1tRhNdbgKvr4U8LQy8zU+Jjid1B0vY74BW/u5CPOehimB5y9YD/Je1097aEwfQc9bQwjPMxqgxQKJ1EFoTov+X8HTpuSZmmLbzqrZGbDnvco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(396003)(346002)(186003)(66476007)(66556008)(66946007)(86362001)(9686003)(2906002)(8936002)(6496006)(52116002)(478600001)(38350700002)(38100700002)(26005)(44832011)(8676002)(966005)(6486002)(316002)(36756003)(5660300002)(4326008)(83380400001)(1076003)(6666004)(6916009)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UizU0ycKjpXAq+/I4Mwc7c+EhjwhV/r8kFCIdXBlufPO65k7AGV03T+Cbzzk?=
 =?us-ascii?Q?QsoiKPPeCNArXQFPU/ejBj9r2V5lQYRaTJyaOsFTcqvm7Qcba1sLSy06VfQK?=
 =?us-ascii?Q?eMx0pmkJ0uuTgA47c7q8P7Rk6RsPAH5mcjaVeGNQik4fQrW3go7eD9lcY2kT?=
 =?us-ascii?Q?L422fszABRriVRmUs00QEziizVsjmytVyrPZfv0pvA9324uWyyo17ym6QV3p?=
 =?us-ascii?Q?LvIKvswGMS62xmg05EsrNqEO5Fx7o+PFy4aNCrVa41hg2wt9t4ebwH62FvlC?=
 =?us-ascii?Q?k4jGQm5D6Oy4VCW/HVdxCgIPpAtqeZpNzgV5ed54WESs0fm9IujZaChb3Lae?=
 =?us-ascii?Q?JD5NTR56n84+vmd8cmhUbx9ql1acWUWsaIC3BZ552feO9neFj3rVhM+5FdT7?=
 =?us-ascii?Q?hJhNPvKN/6xd6xcn2smZYu+9GHQGfvQblZGknIM6zQCvKDM6rF8kmvV0eOT/?=
 =?us-ascii?Q?E61Bxb9TZVl08fFj4kWjYixU+gtT04paEqD/1TqJupLz3TP8xvEET6Bad/Pn?=
 =?us-ascii?Q?Aoyp4LcYoGxMtOUa94qUlDdS4N9+QDgdd/nvsvcvmql9dqC63bUlKsch249B?=
 =?us-ascii?Q?BWlJSEJQ4FH237HIRf7YajeMSM1mtYUMwFHv83Kp/sXvBxqP07a8CkpEG1v2?=
 =?us-ascii?Q?Jzm63XsE6uQ1jaPEzQ2RQYumdKchlfMYt+u7jYi3PzO6vp00V4bPg99ONEJM?=
 =?us-ascii?Q?QitFuUb7tKmogJGx0+ZnZ+x6/0WXyTOoX0z9kUrlbICFGtLrOWPSxRo7OYSL?=
 =?us-ascii?Q?O1JuDBFzMJnU+rNDfpIa8hFpHb90NPwmaIuwIAqVduBtgmKy/0IpTKQbgzgJ?=
 =?us-ascii?Q?Tr1CmAFsTlzTQsGiU7gXj50804ff/tCi0UjlB5Y4ltNBFC6/WM2KbJuPe5co?=
 =?us-ascii?Q?Wtdt8VcQXnLw4+EmXBUqx4jueswUmAl7vDPlqhRWRKPbT5+b+tSHrqp0xIfK?=
 =?us-ascii?Q?XK5i3Ub4rR8Gqk/eFHUotKxKFGjdsEFFd6JaKHEcIqskYohVzkoSo9XSeIYX?=
 =?us-ascii?Q?Ivnx/c3M8spjsugP1JSqahkOwTwC5fEX5rjp+LF63ud60tjGNlRGPZQrhTMG?=
 =?us-ascii?Q?fxUo61+Fh6EhK0QY7FctOB+AdQcTGdmN8D7h+Ct/zn9V57gCcf7L1Qbo6316?=
 =?us-ascii?Q?6G22n41+nAiPCBuyqdtfdvpRCnpjoHHF8lLDnnQiMphToNnkPq99odu7kIur?=
 =?us-ascii?Q?r/YZO+TYQqI2Fd45rgAjILTkKrkjep3EQFGfIQNo/JrbKSFzgdHptx6T2tEy?=
 =?us-ascii?Q?wKW+6VRledi5++N2XkzSJo2d1Gsuy1rEllTcAO4GotkKbNJ/4zjz3vuf1ODn?=
 =?us-ascii?Q?dY5iUq/PkjuyN3WFqI6C6kls?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584361e7-6ba9-4b88-d1a6-08d95d878215
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 11:51:23.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qCPVWz5JRB9GWTQcCMXSePSf2gIVb4AXFXTKx42sG0H3lkbvNKArPC8H6CM7wdJdUs/ZRB9v7OxfWtaIbjxLJNykdyXI4dYjWqwXAhhWlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120077
X-Proofpoint-GUID: J9WI2TAg00NxHNWeXeSANmjVm40nj0EE
X-Proofpoint-ORIG-GUID: J9WI2TAg00NxHNWeXeSANmjVm40nj0EE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   2ca380ea0e6a31046b7c4048e3f61cfc2f6b2aa3
commit: 2545ac960364d0395802a27374b46f13827b4cf5 [10/24] drm/mgag200: Abstract pixel PLL via struct mgag200_pll
config: x86_64-randconfig-m001-20210812 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/mgag200/mgag200_pll.c:142 mgag200_pixpll_compute_g200se_00() error: uninitialized symbol 'delta'.

vim +/delta +142 drivers/gpu/drm/mgag200/mgag200_pll.c

2545ac960364d0 Thomas Zimmermann 2021-07-14  114  static int mgag200_pixpll_compute_g200se_00(struct mgag200_pll *pixpll, long clock,
2545ac960364d0 Thomas Zimmermann 2021-07-14  115  					    struct mgag200_pll_values *pixpllc)
2545ac960364d0 Thomas Zimmermann 2021-07-14  116  {
2545ac960364d0 Thomas Zimmermann 2021-07-14  117  	static const unsigned int vcomax = 320000;
2545ac960364d0 Thomas Zimmermann 2021-07-14  118  	static const unsigned int vcomin = 160000;
2545ac960364d0 Thomas Zimmermann 2021-07-14  119  	static const unsigned int pllreffreq = 25000;
2545ac960364d0 Thomas Zimmermann 2021-07-14  120  
2545ac960364d0 Thomas Zimmermann 2021-07-14  121  	unsigned int delta, tmpdelta, permitteddelta;
                                                        ^^^^^^^^^^^^^^^^^^
2545ac960364d0 Thomas Zimmermann 2021-07-14  122  	unsigned int testp, testm, testn;
2545ac960364d0 Thomas Zimmermann 2021-07-14  123  	unsigned int p, m, n, s;
2545ac960364d0 Thomas Zimmermann 2021-07-14  124  	unsigned int computed;
2545ac960364d0 Thomas Zimmermann 2021-07-14  125  
2545ac960364d0 Thomas Zimmermann 2021-07-14  126  	m = n = p = s = 0;
2545ac960364d0 Thomas Zimmermann 2021-07-14  127  	permitteddelta = clock * 5 / 1000;
2545ac960364d0 Thomas Zimmermann 2021-07-14  128  
2545ac960364d0 Thomas Zimmermann 2021-07-14  129  	for (testp = 8; testp > 0; testp /= 2) {
2545ac960364d0 Thomas Zimmermann 2021-07-14  130  		if (clock * testp > vcomax)
2545ac960364d0 Thomas Zimmermann 2021-07-14  131  			continue;
2545ac960364d0 Thomas Zimmermann 2021-07-14  132  		if (clock * testp < vcomin)
2545ac960364d0 Thomas Zimmermann 2021-07-14  133  			continue;
2545ac960364d0 Thomas Zimmermann 2021-07-14  134  
2545ac960364d0 Thomas Zimmermann 2021-07-14  135  		for (testn = 17; testn < 256; testn++) {
2545ac960364d0 Thomas Zimmermann 2021-07-14  136  			for (testm = 1; testm < 32; testm++) {
2545ac960364d0 Thomas Zimmermann 2021-07-14  137  				computed = (pllreffreq * testn) / (testm * testp);
2545ac960364d0 Thomas Zimmermann 2021-07-14  138  				if (computed > clock)
2545ac960364d0 Thomas Zimmermann 2021-07-14  139  					tmpdelta = computed - clock;
2545ac960364d0 Thomas Zimmermann 2021-07-14  140  				else
2545ac960364d0 Thomas Zimmermann 2021-07-14  141  					tmpdelta = clock - computed;
2545ac960364d0 Thomas Zimmermann 2021-07-14 @142  				if (tmpdelta < delta) {

"delta" is not intialized until the next line.


2545ac960364d0 Thomas Zimmermann 2021-07-14  143  					delta = tmpdelta;
2545ac960364d0 Thomas Zimmermann 2021-07-14  144  					m = testm;
2545ac960364d0 Thomas Zimmermann 2021-07-14  145  					n = testn;
2545ac960364d0 Thomas Zimmermann 2021-07-14  146  					p = testp;
2545ac960364d0 Thomas Zimmermann 2021-07-14  147  				}
2545ac960364d0 Thomas Zimmermann 2021-07-14  148  			}
2545ac960364d0 Thomas Zimmermann 2021-07-14  149  		}
2545ac960364d0 Thomas Zimmermann 2021-07-14  150  	}
2545ac960364d0 Thomas Zimmermann 2021-07-14  151  
2545ac960364d0 Thomas Zimmermann 2021-07-14  152  	if (delta > permitteddelta) {
2545ac960364d0 Thomas Zimmermann 2021-07-14  153  		pr_warn("PLL delta too large\n");
2545ac960364d0 Thomas Zimmermann 2021-07-14  154  		return -EINVAL;
2545ac960364d0 Thomas Zimmermann 2021-07-14  155  	}
2545ac960364d0 Thomas Zimmermann 2021-07-14  156  
2545ac960364d0 Thomas Zimmermann 2021-07-14  157  	pixpllc->m = m;
2545ac960364d0 Thomas Zimmermann 2021-07-14  158  	pixpllc->n = n;
2545ac960364d0 Thomas Zimmermann 2021-07-14  159  	pixpllc->p = p;
2545ac960364d0 Thomas Zimmermann 2021-07-14  160  	pixpllc->s = s;
2545ac960364d0 Thomas Zimmermann 2021-07-14  161  
2545ac960364d0 Thomas Zimmermann 2021-07-14  162  	return 0;
2545ac960364d0 Thomas Zimmermann 2021-07-14  163  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

