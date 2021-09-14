Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7588040A711
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbhINHI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:08:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:59314 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240277AbhINHI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:08:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="209136422"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="gz'50?scan'50,208,50";a="209136422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 00:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="gz'50?scan'50,208,50";a="433552727"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2021 00:07:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 14 Sep 2021 00:07:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 14 Sep 2021 00:07:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 14 Sep 2021 00:07:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 14 Sep 2021 00:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAckj/gRPL9PMSJyyTPLopYsMVhxW/bZHMist1xEJiYrHM98Uz0c93cfne2qEHDEGyvExy7zD+qdNei2+PewUs+yktMwuL5++O6V+yHJWnGd0GA5NClFvMD6RJjDNJqx5Su18hdPIKmGZoTnfxnVOt8snj9ZvV1SDfWERnD3/IM0JX+DVzXx0YqqOmy/5erNGpdOGW1X5ri7HxhWxH5jNwhh7ClcFyjjAAbp1DDxEVp0w7tJWXXbaXJBnY4Fxhf4oicJnGMppjDEeExNvXhCwHeBqmTbxzUHy6zirOPTro6MuAH53JPBE/KUznR7BY3J9j0azS0bw3QspAUEu26Yag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=W6ctPDKIaCf09YrrzqPMbcR6kkON4ZvBD61iEzbOios=;
 b=G0doIDJl2mn8BX1dqG87tujDPyjlzVGD9KDTiNgJEOMkOq6yC92MEL4RyGSqC2q3ba7RefKfwx4cWHtrjtior9RcMghVM7CR3S90EqQ7mogK37vdKnIwg8190r5RqE96CrLO41TZmqtsyeGj1/U8lATC4quJq7dYSEHMyjadUOz1Z6v7XVhPEjjnVPt7Awo1lRdeV6oShP6XRdgVwzpKSV9P0diS+C63PFZXkdB51W711UTe3q+kPgfb/NKbaDuNf2pKUudhHbYdnN9Mg+jP+RGlfeX81fRxsBCRf+OY5PIjqJiEgnOb3l6E0ZvkBE0RCK09tm+QwUngNwQWLPDCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6ctPDKIaCf09YrrzqPMbcR6kkON4ZvBD61iEzbOios=;
 b=B3f2V2mT2wuxmsVGfDGugDIPIKK0imJ/GD+47zhk0iHyzvgpF+d/M5ypr9NBj0xB/IvoHr0cVg2qn24DNqV0RlQKwriwTR5qVCFOrPYmmtd1omGZnat1HifiHFMUT+Crf8IIM5FJWcRm+xOMqfB8Mu6aiRtqrhPpuZ6BQGAkiXc=
Authentication-Results: b4.vu; dkim=none (message not signed)
 header.d=none;b4.vu; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 07:07:08 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 07:07:08 +0000
Content-Type: multipart/mixed; boundary="------------xtBlQdFCDKJDRqIsSsISZdAm"
Message-ID: <e4ac94b9-71fe-2315-a507-6a6bc05517e2@intel.com>
Date:   Tue, 14 Sep 2021 15:06:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.1.0
Subject: sound/usb/mixer_scarlett_gen2.c:2429:3: warning: Value stored to
 'err' is never read [clang-analyzer-deadcode.DeadStores]
References: <202109131831.9IodEzRx-lkp@intel.com>
Content-Language: en-US
To:     "Geoffrey D. Bennett" <g@b4.vu>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        "Vladimir Sadovnikov" <sadko4u@gmail.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202109131831.9IodEzRx-lkp@intel.com>
X-Forwarded-Message-Id: <202109131831.9IodEzRx-lkp@intel.com>
X-ClientProxiedBy: HK2P15301CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::13) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.249.174.70] (192.198.143.8) by HK2P15301CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.0 via Frontend Transport; Tue, 14 Sep 2021 07:07:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd52d35-1fcc-4352-4894-08d9774e4394
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5582:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB558215F7DB8134907E6A2F97FBDA9@SJ0PR11MB5582.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23L6K3FRs1/TLdn3lc9J5JDjjSkSH8WtDsKBKKQpKRfYF8pduW+gn5ohZTJ4zHirzP2X0GZo0aYpXXg4cx95HtI3wZWV1aSw1eS7v57lVIB+DjJaQkkeoGu4ic7D57dinUqGsUGsum9s3vrRtMFtFJIZXuYrdhqDw7Wq5IwKeMPG2s/GPQJm9BrA46hjluqKOVKTirKuycJov3Ehh3THl7AOOOwjp8JdVXCEl3peJOcWOOipe8cjg0ZsCWoQUaY3P7gLWf/T8lgvtMjWKrK+PIFJ11e96dXeADJDhGNeiE5yuIuZUyC/14OiyAGlAU/tDn7fJxAbtfw+Eb2Kai0VeoZqVGLZbPnIEDYhXv+HMejnM0q1X2LtIbGydjl6/DGBUolX+WW/d33/HC740jXhdOswkbIoqq6ws3kOa06Bh0DoXLfh80s7R64Khc/MCsY7WMoVuAcQ8MFmXGyBrjDU+6R8TsW2xTDDzOL7SJyG/Yl97sscF2847WnQmiJTHtISjx2xXr/Z6Y+yharifMcTb+JNR3rkIXP+u911ntgqoqcKifOi2+udDvfKiaC49u/xwhAfBjCECmwtJ7fNUKduCoOl1u13XNCm1VeqXuKlgxY19NnDkurFh8DWqjqWeKYOQD5n3lVemCC1BnFyONj6NZS+iM+1ZhncdmEl5B4ivScBpxTPL71CJOMTuUUPkVuVVqXKPD7XkrkLfM9UxxahJLrNoXpPc2nM1dJnjXeNBWHKzJWvNEqMDwFicGRLGruaSxnWei8S5raquBUlTHDUmmu3LBGWTnMBWcBffr0+5x8PamE1iflVv5uoP1PKy+GfrIEZqWfX4hjryVADN+Sq5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(38100700002)(31686004)(86362001)(6486002)(2906002)(66946007)(31696002)(16576012)(956004)(8676002)(508600001)(8936002)(66616009)(66556008)(66476007)(83380400001)(6666004)(6916009)(2616005)(36756003)(54906003)(26005)(4326008)(186003)(235185007)(5660300002)(966005)(33964004)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWNrbzlYTlUrNlQ5RzdvSzlTWXdYZGI3bld6ZU83bjNBKzBTa2ZKOUNaTXkw?=
 =?utf-8?B?K0VsWmlScmY4d09TNFkyUmt3a2xwSURHdEpEa25la0VxVktUbzZSREdPU0tB?=
 =?utf-8?B?c1VHcXNkdG1remhNWlpTUGZhS3BEcEEvYVR2MFJ3U0wwd0VSTE0zSmVPZm5D?=
 =?utf-8?B?Z3lOQ0F5dkR1OE11TlRrZE5JOStzSDh0NDhoV2JkWFNIck5NazFvc3k3SzJO?=
 =?utf-8?B?MjhPYUNLVVJCOTdGV1hUMEJsV2RlWGMyWEJ4WnlnRUsxQ1lNb25VZ0hsRU0v?=
 =?utf-8?B?YjNVdWNnN0hCdnUzMmJEd0FEU0NRTG9YK2MzOEhwNEdsMHVBeXVxdUxTYU4r?=
 =?utf-8?B?dUNFR0ttaU0xV0p0NCtvbGRwQVEzWmpCbHFDYlAvWFEyTVRQd1F4SytVanoz?=
 =?utf-8?B?RG5lTUF1ZlRoenJQN3RPRmJDUXNQZFZQSG5iQkNsK0VqOG4xcVIyYmZsaUd0?=
 =?utf-8?B?bGZ2SnE1T28rNW9vVW1DUTljWHdzdncwdlhyVk5EQ0lqWUJUK1lNbWlPVnpJ?=
 =?utf-8?B?R0JWSnNBYk9XNDlIaGVXODc1OEpIbTVyNE1oYzYydUNlVk5pcE0zcWtaa1RR?=
 =?utf-8?B?Wk5HRGVrTTJwOWZhTDVObGk3L2M1RUtLMUU3QVNZSURDZXRaNHlERlIydFhJ?=
 =?utf-8?B?aWxwSDZnNUxEbzBaaDEwNkF5eXhEMHRlZlc1bFNXazIwYWJmaEo1QlJBajl5?=
 =?utf-8?B?WmFrY25oMlpWdDl1QmRSWm9hRXVFeTFOT0pJcTB2RXZqZmhiSXlNeWpuZTJK?=
 =?utf-8?B?bDdpcVJVa3F6K1ZQR3BJaEtyeThoTG9YZDFzZ0g1T1NJcnZFZGRBTndwSElK?=
 =?utf-8?B?MS9mUm04NXBwaGh2NzdmWmdKVEVSQnNzbVR4SzdqTGRKaXNZZmNiVXFtVzdw?=
 =?utf-8?B?QlpyWmNERmFoVE5BQ2tUMDloaHM2cXZDUVdBcVNNSHUxUk0zL0REYnQ4eHRJ?=
 =?utf-8?B?OTlZUkVTQTQrbmF3b1c2WEtpNXVtaXRlVWthSy9yWVdwYTRFUFNJVVQ1WnRI?=
 =?utf-8?B?WTJ6d2FuTXR3VzFwOVMrYVBCOE5KUDQrYlJ6ejN2Smc0WUEyOG9wV0JHZ2lQ?=
 =?utf-8?B?dWdtQ0JzU05KM3BGcWJlUlhkakxUUEkwSzhhSVBIS2ZuOFZMZ1FTMnpBNkZ0?=
 =?utf-8?B?Zm5PTVYxMXF2UFZIc3l6V0tMVGVnV0c5cFJQaE9DSEF3Z2RIUnFiMFNoZzZG?=
 =?utf-8?B?U0F3Ukpscmk3MUFxWmJreURJNG5DcUo3S050VHdJanM1Njd6YkpPTXNEV0x2?=
 =?utf-8?B?NlYvYUNtMnN6RUx1TUMwSTBQM0oxRWM5VlF5b3BHWU5JWXZTYXlRQVJBQ2hB?=
 =?utf-8?B?ZGxSeExlVHZ0d2tJNXJPaFRRaEkxeVRSbG1ldjR0bytHR3ArYzZFODN5RnFN?=
 =?utf-8?B?WXJJRG5mTnRZMzhOSGFiejhIV3dpN0s5eEMzYmVBUGFhNDcxRlg3eUQzNEwz?=
 =?utf-8?B?cWtlL2o5SmRVZFYwZ2JTM0trd0MrRE4ySXE4M3Fjc1JqUnR1M0RHRkVyMHhM?=
 =?utf-8?B?NGpDQ3ZKUDRENElNV2ZCeFZNb01uOHJBUTExSHpqdEJ0YUt6S3ZFWVZQcXls?=
 =?utf-8?B?d3VLS2JHWUozYW03cDl3amNVOEtjdUV2UG9xZGpkQW5ndTNOZi90SDh6VzV2?=
 =?utf-8?B?dkw0Mk5jeGF3dyt4QXY0YVZGRW1sTEV1TWRkMU9MeXEzZmRibEduMmludTRr?=
 =?utf-8?B?NzNoZFRQYzhpZFdvUmZtLytuTHpnOWM0S3NLYmJVUHhDVWd1ZmI4U0hZVy9i?=
 =?utf-8?Q?hgjNyTMyo6ptrGtfUWBnb88LpLO4AFMwuQgSjqS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd52d35-1fcc-4352-4894-08d9774e4394
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 07:07:07.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB5Y4opfeYcCmW/QUS6vUwI1JHnf5cueOORy97FrK1yRrzL9RMaZOcbnzOIE4j/GJEwsAsZ2ucNaxSmwuDURQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5582
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------xtBlQdFCDKJDRqIsSsISZdAm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
commit: d5bda7e03982f67ce2f6c0d79b750fb27077331a ALSA: usb-audio: scarlett2: Add support for the talkback feature
date:   3 months ago
:::::: branch date: 11 hours ago
:::::: commit date: 3 months ago
config: i386-randconfig-c001-20210910 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5bda7e03982f67ce2f6c0d79b750fb27077331a
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout d5bda7e03982f67ce2f6c0d79b750fb27077331a
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> sound/usb/mixer_scarlett_gen2.c:2429:3: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
                    err = scarlett2_usb_get_config(mixer,
                    ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/err +2429 sound/usb/mixer_scarlett_gen2.c

6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2369
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2370  static int scarlett2_update_monitor_other(struct usb_mixer_interface *mixer)
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2371  {
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2372  	struct scarlett2_data *private = mixer->private_data;
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2373  	const struct scarlett2_device_info *info = private->info;
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2374  	int err;
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2375
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2376  	/* monitor_other_enable[0] enables speaker switching
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2377  	 * monitor_other_enable[1] enables talkback
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2378  	 */
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2379  	u8 monitor_other_enable[2];
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2380
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2381  	/* monitor_other_switch[0] activates the alternate speakers
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2382  	 * monitor_other_switch[1] activates talkback
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2383  	 */
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2384  	u8 monitor_other_switch[2];
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2385
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2386  	private->monitor_other_updated = 0;
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2387
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2388  	if (info->direct_monitor)
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2389  		return scarlett2_usb_get_config(
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2390  			mixer, SCARLETT2_CONFIG_DIRECT_MONITOR,
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2391  			1, &private->direct_monitor_switch);
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2392
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2393  	/* if it doesn't do speaker switching then it also doesn't do
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2394  	 * talkback
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2395  	 */
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2396  	if (!info->has_speaker_switching)
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2397  		return 0;
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2398
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2399  	err = scarlett2_usb_get_config(
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2400  		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE,
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2401  		2, monitor_other_enable);
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2402  	if (err < 0)
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2403  		return err;
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2404
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2405  	err = scarlett2_usb_get_config(
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2406  		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH,
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2407  		2, monitor_other_switch);
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2408  	if (err < 0)
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2409  		return err;
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2410
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2411  	if (!monitor_other_enable[0])
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2412  		private->speaker_switching_switch = 0;
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2413  	else
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2414  		private->speaker_switching_switch = monitor_other_switch[0] + 1;
e914d8432cb4b9 Geoffrey D. Bennett 2021-06-23  2415
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2416  	if (info->has_talkback) {
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2417  		const int (*port_count)[SCARLETT2_PORT_DIRNS] =
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2418  			info->port_count;
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2419  		int num_mixes =
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2420  			port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2421  		u16 bitmap;
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2422  		int i;
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2423
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2424  		if (!monitor_other_enable[1])
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2425  			private->talkback_switch = 0;
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2426  		else
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2427  			private->talkback_switch = monitor_other_switch[1] + 1;
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2428
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23 @2429  		err = scarlett2_usb_get_config(mixer,
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2430  					       SCARLETT2_CONFIG_TALKBACK_MAP,
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2431  					       1, &bitmap);
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2432  		for (i = 0; i < num_mixes; i++, bitmap >>= 1)
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2433  			private->talkback_map[i] = bitmap & 1;
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2434  	}
d5bda7e03982f6 Geoffrey D. Bennett 2021-06-23  2435
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2436  	return 0;
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2437  }
6ef9fa4a0eb4cd Geoffrey D. Bennett 2021-06-23  2438

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------xtBlQdFCDKJDRqIsSsISZdAm
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
DwJH8/wNuE+GQDBuAgA=

--------------xtBlQdFCDKJDRqIsSsISZdAm--
