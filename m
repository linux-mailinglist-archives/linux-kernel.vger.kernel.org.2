Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A25460BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376804AbhK2BFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:05:13 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:43330
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230467AbhK2BDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:03:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X18YN5qogHvOJxh78i+/IIDxjha56Tut2Kbd/Rh/g42E0cDBM+HzAlB/K48X51gCxxKo8LSqJF70/9p7b5m7GIYD7H4jB1AkTxPMgJxgZtiGP/kndoim5uoEpAcEtajH+gbioruhbUmZC8ooumarCVCn9/HweZBYSfW0nn9tiaGMdJ8zOT4VSPmz4k48bL1mQnacuAOgA83iJGkYuCaS8aZGc9mfj8SnwVnMhoMeDXWx9S+fFPk7XVEbB8LbkaS8d2ZtBH1DzViyHqqa/YkF6trvtxnhCryqLJLKeHjjfznFJHPmJ8QAQm29Ji6EIxM5sTolTZUWgiS3oNc21NfE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/MxZIALsKErCBWU0I+szPGI2P3xAhWURfrnCG+M2C0=;
 b=ax5uvXVjKN5uyg2d3CBpADfIl1ztdNedJvOZwIDkCy/lhmIbDFPkIea6qO8g8Knpd9xdvy2iIuaBQZ/7cdtSwjQc50pBm5ZhUY3/kbqgnaNfw5imQk+nFVMkWxLxe4HfuQPcuPVKEObiekxQYnxJ+nNTPtYpJoBtZXmafwO1VyLNWXkBFPDfFokNL7nAObzX7HD7KonK/4oKfh+XPwgheXo+m2PNd70vdrDFaQTClQsiVu/Ka5eDP94Eg2EeYCtAmsNOP13mbq2dsIBmrkXTu+IjfBLd87Y6FTTqrpxMwDiCQYtgM9ZexHCudT4umcZgMkhvAXFGfc83gof9BV8Png==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/MxZIALsKErCBWU0I+szPGI2P3xAhWURfrnCG+M2C0=;
 b=L20pzz54XWKmipLpaoVaMzWTnuhUWhigHSwiWi4jXcNRQxiz/UpsQ8fY86nz5FM6bAuSFoZhkDOkFbM8l1NLM6NR8rlUMa+EjQN8qzeW3dTzyaspzJrlEZ7naWHMlcjr+UdS9P0XQQpVp3bW08Oo3BLDjd6qoPhmAfbQTB6boKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by BYAPR08MB4149.namprd08.prod.outlook.com (2603:10b6:a02:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Mon, 29 Nov
 2021 00:59:47 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b015:39c1:b102:608e]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b015:39c1:b102:608e%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 00:59:47 +0000
Date:   Sun, 28 Nov 2021 18:59:42 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: drivers/input/misc/iqs626a.c:1645:12: warning: stack frame size
 (2448) exceeds limit (2048) in 'iqs626_probe'
Message-ID: <20211129005942.GA416687@nixie71>
References: <202111262250.Y0l0olCY-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111262250.Y0l0olCY-lkp@intel.com>
X-ClientProxiedBy: SA9PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:21::18) To SJ0PR08MB6544.namprd08.prod.outlook.com
 (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
Received: from nixie71 (136.49.90.243) by SA9PR13CA0013.namprd13.prod.outlook.com (2603:10b6:806:21::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.10 via Frontend Transport; Mon, 29 Nov 2021 00:59:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c227dba-841c-42f3-b109-08d9b2d38a2f
X-MS-TrafficTypeDiagnostic: BYAPR08MB4149:
X-Microsoft-Antispam-PRVS: <BYAPR08MB41491EAE61297DC930D0B30BD3669@BYAPR08MB4149.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Foi8subCP5HVrEmFDdD+Gs50CO6DcA5RisG+t53jlp8NCvSbq1h0tKZF4Y+fvIdthK7xC97md7sQaQdEzBJHw1nX+cC3HHEUf3MFYMX16LQrFjgjtQSIAAZiPRrNoGgRXGvWwXzdeAfSAQBoIr0r9/3AnljiztHr/YeApVWs95IjipuMaIIsEs9RiNxo6A71BLYSYMkNWHlyCB0KWFlRp7+V26dC6sT6XdWZzjrklRz9SmGc0IGtNisbDR6cl4sqM3iw96LpoY1KdMo9/kMsgiK4NXpxYi3EIkh5sPbiW7c+XKvG8XGnP2FndZVIEyapfHzIWqKlTIP+xS/mmZomWYUU9dDvw3x0+Fkm7rYX3CVOFOqJw6MnWwv8PeBZTm8gNvjcDTug+9Qb/fSJOUWooUlPS+vurMAD/98bkObVFUHZO9ITkgLA4nq8348V0J4awH7L7Hyll24bXLLRdk8pfJ7XoYHlTBRNrwP6iJJeoht2lLyG0CnwgVJfUxoDa588n6NjQpeh2ea2ZWrKAFVavE6bLncIy96ZQtnrBoqGQAZkaJyzMEo2IpEf382wYXGzLkMAtrvU9mPb+twvPCdzt1DTJ/Ssgbw+XyIkiJnyxjLPrDBSTpFAAOG86yJuponftWm1j2pePYF/2j/giEyHpTy9Y6Ocz6BOs4Ifz977RqHvw9C0ttZTKG4MVjRK/5SQMMdVu5FnRNilx5xk4NDzMpwiLDKdCknsYsd9vsr/gqpuE9BHK6g2JhL50jHkcqptwqLebYiqzdn7z0VHNxZTaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(366004)(376002)(39830400003)(956004)(26005)(33716001)(1076003)(83380400001)(9686003)(6666004)(186003)(86362001)(9576002)(52116002)(38350700002)(38100700002)(5660300002)(6916009)(2906002)(55016003)(66556008)(8936002)(6496006)(66946007)(966005)(66476007)(33656002)(508600001)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3v/3DrcWhBm1DAhfq1mcWhtl63QXu6T3pZrG73RPdq6R3payJGxQr7gBVD8m?=
 =?us-ascii?Q?4e9BM28SRYFJbByUwNU48Gwq1ni/D9vDHRs5uOQEiq1dx2Vej7TLaAjNnWms?=
 =?us-ascii?Q?nMGYn8KaPjhyJ+ZWZM7PIcV+TAZ56C1HC/CEMmmLvyPGrSdUY4SDHHSeIJQz?=
 =?us-ascii?Q?3Co9AgqUOomoH7vX77KjQyAySdMGVKtIPcUtdU5MKQAIG1IuA9HxU6uh3CZh?=
 =?us-ascii?Q?I4Iaemb0ktiGMNZQbcrOb/jOYb1GPsrPlAYjmYC89gfeTNyZgZrsL1PkF7+R?=
 =?us-ascii?Q?BzbUHEegHuNefj3GGxC4wTqZN3ykFdQp5d3AI2ow/rqZQ2XfALDjE1z/1izm?=
 =?us-ascii?Q?vAR2SeRkSHKG9iC6agg4PI+tha9anHsS1KqXbMGsJpJA0ymYZnTRAdqzI8Zv?=
 =?us-ascii?Q?emGH95L7dgNCsJmfVIDoqLfI8NG5+BTYAkAeNOYj0d+NiznKLAVWS1BiTEzl?=
 =?us-ascii?Q?RLRQ3xCvgNgRkaRNRn18aM3DFSgsWvE9iWD1Rr/9DW3CSmONZ0s4B6q79WTi?=
 =?us-ascii?Q?RVRVkpp6aAF44mtsOYgN3B1ySGJriHV6LOjYwVQ8Ns1akujaE6yCxvF+vXyP?=
 =?us-ascii?Q?6Q2C1utQSpbr1ORzinqbS3Mw63XLYVZO4o74RQcmyTjc0WFtrqVYFNg4JT7m?=
 =?us-ascii?Q?rr9P4SgEp/X80/g9qHYHJWp/JG/DXS16sZFyHdrmnQ9enxMlDF+uaW9Vpve0?=
 =?us-ascii?Q?6XV5vAcugNy3HTe92VnlnTBKfZN23T2Ntv/V4lQbKadk6j/SeudWTgzX8sq/?=
 =?us-ascii?Q?VM0cVaSYwklZ4VZ0qXKpmdirwturbBl9dmclrnXIj/fHb/CEGbmPIdGHss9K?=
 =?us-ascii?Q?TasJZnuknVyEAvjElxhOZ7392yUPuee10aWRnFQ6XoweJiIOPJS4NkQFhC21?=
 =?us-ascii?Q?pr4CWMGbpnvgkKE2MqxgcmQmojVhLAO4Xol7mhF76dWS5955fjMJUT/FKSWt?=
 =?us-ascii?Q?lBImxZaReP3+li/VOLDuVOpbSyDW4hrNwOiE3eD6THStxUSHbT1IbJb0mytd?=
 =?us-ascii?Q?3pBhkmKd8Hb+vcTOJHXBqRRiLPSTvNLt0CPkOlTvV5GvmGXjWo0pmzdnR3cv?=
 =?us-ascii?Q?jCvEJpi7yfasI5CDHOtodVEz8pREakdXw0/cjXxKhMarTsyn3fCr2Z3bFfP4?=
 =?us-ascii?Q?DfPwT8JCqWhFsr+9qz1czTOV8WfLmAIr5edCXurbGZKqSwbHuPO0Oc+PjDJm?=
 =?us-ascii?Q?XngRgbme8oCaeHq6FHZrexov8/quZZGevsylZFp6uUAuejDSKi8p1Tv0DTwv?=
 =?us-ascii?Q?U2zpa0SWfrRFB0tPIkdua9EFN+nnFrgnMHxFetnwZSg+ePFSspfsitqzuGyk?=
 =?us-ascii?Q?pqtJYw0NjnM90aCTaS+m0JTLBC5L91WOHfo0q5ZCi+MZ4o+O+r0AUS58RrDM?=
 =?us-ascii?Q?ca5G2UZU6LrmkcfvRpdlHFminX7rN+d3LC05twnHRZ8EI4jMjRPlNh1QTV77?=
 =?us-ascii?Q?HDSsNZynGAOzqdQ74awmoc3ch4GHO4OLi+DXYtIlY1/zwUWzB0aFGm/RHPfJ?=
 =?us-ascii?Q?Y/M+utS2a1z06toUel6fMUrby7fWs2ekUCvWLjpO8vHCSErVsAxtal+W+piq?=
 =?us-ascii?Q?E+qnncMiWOSZBw8Mll9rEymXYvA1hVd8gMsn9jZS6rnuXCKoG+VSHP7AgXO+?=
 =?us-ascii?Q?UiRpYTku1hLexKf7TthHZmc=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c227dba-841c-42f3-b109-08d9b2d38a2f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 00:59:47.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4C/QGY9BtHmQ7we4yHZGW2kUZRykzaPvU6DfjXIIEMgu4TpHIWFZJYbq+bR9365Lh2+K4CH6nKKxHK3gYw/hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Nov 26, 2021 at 10:27:30PM +0800, kernel test robot wrote:
> Hi Jeff,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a4849f6000e29235a2707f22e39da6b897bb9543
> commit: f1d2809de97adc422967b6de59f0f6199769eb93 Input: Add support for Azoteq IQS626A
> date:   8 months ago
> config: mips-randconfig-r013-20211124 (https://download.01.org/0day-ci/archive/20211126/202111262250.Y0l0olCY-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1d2809de97adc422967b6de59f0f6199769eb93
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout f1d2809de97adc422967b6de59f0f6199769eb93
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I was finally able to reproduce this report with the same steps; the
compiler appears to be inlining several functions called from inside
a for loop. I have posted a workaround in [1].

> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/input/misc/iqs626a.c:1645:12: warning: stack frame size (2448) exceeds limit (2048) in 'iqs626_probe' [-Wframe-larger-than]
>    static int iqs626_probe(struct i2c_client *client)
>               ^
>    1 warning generated.
>    Assembler messages:
>    Warning: a different -march was already specified, is now octeon
> 
> 
> vim +/iqs626_probe +1645 drivers/input/misc/iqs626a.c
> 
>   1644	
> > 1645	static int iqs626_probe(struct i2c_client *client)
>   1646	{
>   1647		struct iqs626_ver_info ver_info;
>   1648		struct iqs626_private *iqs626;
>   1649		int error;
>   1650	
>   1651		iqs626 = devm_kzalloc(&client->dev, sizeof(*iqs626), GFP_KERNEL);
>   1652		if (!iqs626)
>   1653			return -ENOMEM;
>   1654	
>   1655		i2c_set_clientdata(client, iqs626);
>   1656		iqs626->client = client;
>   1657	
>   1658		iqs626->regmap = devm_regmap_init_i2c(client, &iqs626_regmap_config);
>   1659		if (IS_ERR(iqs626->regmap)) {
>   1660			error = PTR_ERR(iqs626->regmap);
>   1661			dev_err(&client->dev, "Failed to initialize register map: %d\n",
>   1662				error);
>   1663			return error;
>   1664		}
>   1665	
>   1666		init_completion(&iqs626->ati_done);
>   1667	
>   1668		error = regmap_raw_read(iqs626->regmap, IQS626_VER_INFO, &ver_info,
>   1669					sizeof(ver_info));
>   1670		if (error)
>   1671			return error;
>   1672	
>   1673		if (ver_info.prod_num != IQS626_VER_INFO_PROD_NUM) {
>   1674			dev_err(&client->dev, "Unrecognized product number: 0x%02X\n",
>   1675				ver_info.prod_num);
>   1676			return -EINVAL;
>   1677		}
>   1678	
>   1679		error = iqs626_parse_prop(iqs626);
>   1680		if (error)
>   1681			return error;
>   1682	
>   1683		error = iqs626_input_init(iqs626);
>   1684		if (error)
>   1685			return error;
>   1686	
>   1687		error = devm_request_threaded_irq(&client->dev, client->irq,
>   1688						  NULL, iqs626_irq, IRQF_ONESHOT,
>   1689						  client->name, iqs626);
>   1690		if (error) {
>   1691			dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
>   1692			return error;
>   1693		}
>   1694	
>   1695		if (!wait_for_completion_timeout(&iqs626->ati_done,
>   1696						 msecs_to_jiffies(2000))) {
>   1697			dev_err(&client->dev, "Failed to complete ATI\n");
>   1698			return -ETIMEDOUT;
>   1699		}
>   1700	
>   1701		/*
>   1702		 * The keypad may include one or more switches and is not registered
>   1703		 * until ATI is complete and the initial switch states are read.
>   1704		 */
>   1705		error = input_register_device(iqs626->keypad);
>   1706		if (error)
>   1707			dev_err(&client->dev, "Failed to register keypad: %d\n", error);
>   1708	
>   1709		return error;
>   1710	}
>   1711	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

[1] https://patchwork.kernel.org/patch/12643273

Kind regards,
Jeff LaBundy
