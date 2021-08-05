Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8AD3E0B23
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 02:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhHEAXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 20:23:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:2777 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhHEAXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 20:23:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="193632997"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="193632997"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="442094226"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2021 17:23:22 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 4 Aug 2021 17:23:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 4 Aug 2021 17:23:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 4 Aug 2021 17:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcGK6VVRC1/F8lxAeZFBBzWvsytp2K5uj4t69tdallJ5zT1ovbQhHGxKIh8vmGHTKN5u7LzY22N2CWEb3bRNNT9kVx6wMUK7sATuw1ZHjFIG/hvUjE8AGeVTNRRJIGG8LFDhKgjV2vDYmNlp/9nRfsMDEr1mAaFxzwUryOS/YKZMzFcsNBERbZxg7+lgXk9Cejvfx7J+uANIKfu0ub6BvATzPDmbrn8eKifISDZfFCVzJzPf/2RfVb7meYDAOV/bFjSa6oWyAPHSDwLZmJuVXqVxH65wKDO0d54sMxkO5QChCG08ETuPCohP6+3izkTk11GZlTlIWluDWIlYIhvpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urJgo5AjNojuxqOJ0YANqTiliLlRpFzZsHR/Bi07FRs=;
 b=Y8NjWhW6v3c4P7N2pgl3dzU5R48B/fZXjKVLwanwk4jZD1TIF07eQpSptBQr9breZvQq0eTxTyrPsXKTuRH39wAm9wYyPaLbUxHjHN3GUsYLCk7U0fQT5L5HDSzI9NKXxkJF/HhAmfmTKIO9zbG3yWvrT9zEHr8SHr00VyHIP7IKw0zk8t0sDfT5RgYrOHZHrTfV3ssRY/k70TAvsqMk9x/ev6viY+gQvBc60S6YTe4c5RxwWfJaYXafnzb0wBDOhhCG8i4qp63iqit0p5gy3IcdcEFWcwVd5vNxLQVDqJJDhSU9jY46Qf+BNycri/YVZ6DS7ZhL0ajttIi50/5tBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urJgo5AjNojuxqOJ0YANqTiliLlRpFzZsHR/Bi07FRs=;
 b=EQMQto1zJdUt45bCXlV5jH8VgYPXXK5zylY+dhs0C7TA2mQAEKd4Q/1WW8gxNdZJzJflJQIWPO5vFp6Na6RyX/T0ht8VaRvnU6Y2bYGiGs+nbM3IDcDzgjjZJDH8QEkZ701ceiDTs0sSZVialzI/c4cu5ZRs5txkHoVC4k/+uuw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5050.namprd11.prod.outlook.com (2603:10b6:806:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 00:23:18 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 00:23:18 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Moritz Fischer" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Tom Rix <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Subject: New firmware-load case for the firmware subsystem?
Message-ID: <b9f07520-c5cb-927a-fba8-0f975c885f7d@intel.com>
Date:   Wed, 4 Aug 2021 17:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 00:23:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f72755-8ead-4dec-fea2-08d957a73996
X-MS-TrafficTypeDiagnostic: SA2PR11MB5050:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5050508F9F20914F6001066EC5F29@SA2PR11MB5050.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khQL/NJ/TeOAGwVJKXCZ4jIYwc2jt+011ynaSHja3XndNPpNX/Ci4In/K5Dlk16cNxYoUhOsvrR/1HvRm+RFoAkqUJag7jB9JOUTh/fpLI4xstzgEcl5ljrkdnMeiYXelTI8/meFqbUP+pV6iDM+pcMC0M7mmgCZqlLP4G8v5jQ37L3WA2jYZ9HCpwVEmhzW/sqG4rWmYKy5W0+YKPHbK8oOXzbL5TWBk5/PfugN2B4NRXzArTj3rpHwQVL6k1UDpY7dme+usque3ZhfpU0jf2ApV5E9WL1vQ6AzmU8/7fjgsSMXsQtlKcODo1IR4kULfC4qyHiIa/BceWEHym0YFfUCE+7oNPkQ33b2eUX1jUUtg5FMb8TS60CDsiAghkcWI6eCf2Gmw6yFfbYg7OMNNt2Rf6jE2EDxG9o2GAAFAGrZUM0cdff83PdAqETLlFWcwJXoALQ55Ip9To/ctPTpjFZI/vY+68X7Y8ox4JQrmkdJZBZQ96qovtcQaVK7Ify2lxlnh9zXdT89r6wnRvVXjFPVaFwrEiJB455Ez1Hho60a6921yqfn0CTLur8ix7zvNFcDGsOlDxDRTOIaSBH2PPSFRshlTEpecTVpXkTHW/KAITlvq594iWpiuXi5JrzfMYELSewH6RI+BSysbXXw9/3e1/uO5k1XnjKMyyYALi1yFIWCTwqf2OX4gan2w9I5n6NSL7YT4W0BOpgRCSeXX/p2gPLhmMmKqkfkCO886zC6tS6raG/DdXy86Mt9kf45NMWIKNgnROcURqlUrHWUBAF4Dm+V3x9ZWNUGWVajqpGmMTZBxby48ZI2EaqMh279/or85Q1QeBxumTZ+O5EmmYr+Ack9oCN2D0g73d+5qqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(6666004)(26005)(2906002)(6916009)(2616005)(956004)(86362001)(83380400001)(5660300002)(38100700002)(316002)(36756003)(4326008)(186003)(6486002)(54906003)(16576012)(8936002)(66476007)(66946007)(66556008)(31696002)(31686004)(478600001)(8676002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0JBUVg5N1NNRy9uWW0vZXl3S0xEOXRHWHFZak1meThMUmx6MHUyUWN1M2tr?=
 =?utf-8?B?eVpCS2RETXpEeWUwSGRzV1FYd3l2cmFDMG1hMk8yQ2oxcUFIVmZlY0l0REpL?=
 =?utf-8?B?dE1Iei9Sb0JkcnNVVnppQnUzb21wQkt2aWtVZWNobDZ1WkFpeVBmNVJ1RUtF?=
 =?utf-8?B?Q3BrZjNrNEp3a2JUcWMxSWJEanNPMVczRCtTbld6R0Q1Wm9YYkNIaDNTUmZ5?=
 =?utf-8?B?Zm0rZDg5MGRRUUltRCtJbHdTcFdWYlBpaDhVSWpKMzNhZjZmRjlrMTB6TlE4?=
 =?utf-8?B?dDczOVRYdzBBc2xwYmZicmpncEgxMEs5QmEwU2RhK3hMT1N5YkZ6QmlxOGd3?=
 =?utf-8?B?c0kwVmMxWHdTS0t1dU1sTURYT2xTS1BWUlcwdzNIbXN0QjNvcW1JbmNtcVVF?=
 =?utf-8?B?OFNyWG9lQktDRTlKMGNWR3JjR0gzcG92OUJsdDJjdldJUXdyZ2VsdFhLaTc3?=
 =?utf-8?B?UlhPcytUUGxidjAwK1U2d3JjMS9VVURWMGhpd0ZOUzlMWU5XTmswTVRIdzY4?=
 =?utf-8?B?STRUU09YbUY5NjZrQ3RJV2k5ZHBCajZ0TGNJK2R4c1A4QTBmSWZvQ2wvVlk5?=
 =?utf-8?B?ellETlIxUEZxL0lURDU2Q2hRT0JxQ0ZKWnFzTkp6ZmpjOEtac0JmWW01QnVj?=
 =?utf-8?B?bmZFRzhLNHc3a2RTT0pHQUJqOU1IbjR5LzEzcTRYWk5uaWNzVXhQL2RQU1Vu?=
 =?utf-8?B?MVZnd0VFQW5CNExlZTBCYVY5TnJFVEVreExzd1dkdEVZOUdueXJlS2piMXEr?=
 =?utf-8?B?aThCUWNIdW9nTFcwY3J6cTJodjJuVFg5VFo4SkJzV01mM1hMNm1ZNEQ1MnE1?=
 =?utf-8?B?cGdPcTJuQ0l4cDVqbTVjQTFnZ0UvMFczbmgrUFlRMDZ3U0c5OTJVOERuUUxE?=
 =?utf-8?B?eDB3bUdMRWxUTGFzS2g4ZjJ5V2hDSUZlMWJscXJyUEkrMDU1YmJTN2sxNzZl?=
 =?utf-8?B?b2FFUjg1REowU05qVms4TFVZbXNqaWhMSWgwV2c2WTA4TGNlMk52dVRnZk5r?=
 =?utf-8?B?K2NybHVIdGgzOE4vM0RLQ3d5NEoveXJyVTQ0dlhUMTZ1dmdzUmcvbU51Uyt5?=
 =?utf-8?B?dm03bXY4eGQwaVVIRmx6MmxUbUFwelFDVk1nYlBHY0lmajVrcmJSdXRYdFhm?=
 =?utf-8?B?ZlFrdS9VS1ZIT2VSck9DcnpxMXdxTGlFcUZhdjEzKzlWYkU3cERhOUNHS2hG?=
 =?utf-8?B?TGxqLzZpRjdmT1MxV2xrQncyb05jRFl3RFlTWW9VN3gxeitDL091U2hXTkg1?=
 =?utf-8?B?OXphTWhZS1lLK1lCTHdVNi93dE9wRlV2VTNpRlI0eE41NkFtaTljTldyYURJ?=
 =?utf-8?B?a3ZtNkhWYmxscis0czJmSzhIMlRnVlhIcmM0RVBNRG9ob2J5MS8yNVZwUGhZ?=
 =?utf-8?B?aWRhWVQ4d1o5L2pKalE0b2RFMk1iWmQ0cXhlK2MwMWhBLzBiQk44Z2hyWVJP?=
 =?utf-8?B?UG5sSHIvS2N5VDlvWWtCTThXMTEyQS9nT1ZuMWx2clh5SkczOUwxd25weGZG?=
 =?utf-8?B?U2NpczNUcFFZb1pDRytNcnhRVithK094ZkEwclFiNkdzWDdCV1FUUDdWNmFl?=
 =?utf-8?B?ckxwcHEySWI3MVMwZjJUOUwzNDU0MGpSWjc1emhMaGRyNElRODE5YUlMQXl0?=
 =?utf-8?B?QUoxRWpPakVxRXk3cTByTEtzamNKMjhVY0Y2cENvc3dBbStQSXFJYk9RSGVF?=
 =?utf-8?B?QllaUHI2ZWlEWUl2SGQrbENrNDZ5d05RZWRabjhCMEZkMlI3aGVOQnp6NHBM?=
 =?utf-8?Q?iUEt8lSHeoB3uA7ebip4pJEWuhTXZslafxCXAIg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f72755-8ead-4dec-fea2-08d957a73996
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 00:23:18.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vniqry7GbdbaObL2cCxs/W/YW5r+2KhMg45EertAUTnyb5jOi7++kGombwuOM1c1aAcFKYIc4tSjUIRJxcOoCYWurquY4U+ptJofnhKMVdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5050
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

I have been working on a driver to allow updates to an Intel FPGA PCIe card.
In a recent email exchange, it was suggested that I investigate whether
this functionality could be provided in the existing firmware subsystem. I
have been looking at the firmware subsystem. I don't think there is much
overlap between what I need to do and what is already provided. I would
appreciate your thoughts on the following.

For background information, this is the email thread I referred to:
https://marc.info/?l=linux-fpga&m=162810644009070&w=2

and this is the last submission of the driver in it's current form:
https://marc.info/?l=linux-fpga&m=162742505425902&w=2

In a nutshell, these are features that I believe are not currently in the
the firmware subsystem.
 
(1) Updates don't take place during driver probe / initialization. The
    updates need to be applied while the FPGA device is up and fully
    functional. FPGA image updates and firmware updates are stored to FLASH
    and do not take affect until the card is rebooted.

(2) Need an API to allow the user to initiate the update and specify
    the image file. The images are signed/authenticated files that are
    authenticated by the device using installed keys. Some image types
    are expected to be provided by the end-user. For example, the image
    file may contain a new Root Hash Entry for Partial Reconfigurations
    (which are under control of the end-user).

(3) We have one update case that can take up to 45 minutes. In order to be
    able to provide some sort of progress indication to the user, we would
    like to do the update in the context of a kernel worker thread, with
    progress status available through a user API.
    
I think I have the following options:

(1) Continue to develop an FPGA-specific image update driver

(2) Consider a more generic firmware update mechanism that others
    may be able to use.
    
(3) Consider integrating this functionality into the existing firmware
    subsystem.
    
Do you see any opportunity to share code? Do you think this functionality
would fit in the existing firmware subsystem?

Thanks,
- Russ
