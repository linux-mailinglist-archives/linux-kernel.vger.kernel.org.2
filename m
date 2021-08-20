Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8253F362B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhHTVx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:53:26 -0400
Received: from mail-mw2nam08on2048.outbound.protection.outlook.com ([40.107.101.48]:14432
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229760AbhHTVxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:53:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2MTZrLLR22pod5+s8p9OX7rRhKub1QJg0jy4qpAxBCjgCzuZ3b3dPrCE6Sx6Rq0TwNVWn1QB3fix3IPXBDkak457wJJZmo2l6KW2/acy0VSpwhy6fqcFxnXEVVHviWG7hrR1WmEVT52NawE1U1ds6Mh27P7ybRcrVb8hMfbSwRie5HccBUDvCnmFxDwe17O3eftf6ovauFpnRBFQ+M6oLFbJBubcMKc7VUoAbyA5V2WTQJCnBxtbv83jjC8aGDLzxZkAbqQNUPOy5XEaoVl00WMOHO+gGgu4YGVh7jC2Q1VFEtAvaFC0XaxFLrrTY3HQy5N11wQRHwZKfWi3Uurwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1T0g2cT8e7hdXlQa6PvHyNyvAIhmpGlnfVNmndlf+o=;
 b=amFGM1xjCUyqphHm+vCeME9adJYtPscWrzErzg8zNI+9tzdLJdhWffBq7/H2IFUwRK0HHm+TiJSlVZxhzsf/bLEXDHBwIJRWhHPLouU3dYxntlTfCnd4EtYtyF92diG7MalUaytYnMaweanEMK1er0hHw0XPXfms5hkupP6OIPFOCQPTpFbo7VRLMYJyU8AWGWFvdW1TElzXuzKtThSON9OCtCuTKaJhuqMs24Dxyg25qSmnrcfcpPphDHiRzIfOHIWhU/QSqLrxDfCds3qfZYspg7hEfqRYUnUZ4Z1kwJWDuo6wotHLwh/LOntS/gBSVI5urnkmHQloSwP4jMs6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1T0g2cT8e7hdXlQa6PvHyNyvAIhmpGlnfVNmndlf+o=;
 b=pxWNdl6CKnpd8Z21uUnw60PBPBAOQ5PDi38M0k0o3n2QWfjArIfrOgGx29qq+Ng47+Rlnf5RFSV/L3oxp0ZhjgyyXEooMnnctExsjbPvv1pwSdFhYAlMCMCwmthssZo1nK00Uva1fQO2sEHC/EpH+1pLOM5JDcLV+qRTs01/uCI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW2PR12MB4683.namprd12.prod.outlook.com (2603:10b6:302:5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 21:52:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3987:37e5:4db7:944e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3987:37e5:4db7:944e%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 21:52:44 +0000
Subject: [PATCH v2] x86/resctrl: Fix 'uninitialized symbol' build warning
From:   Babu Moger <babu.moger@amd.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        babu.moger@amd.com, hpa@zytor.com, reinette.chatre@intel.com
Date:   Fri, 20 Aug 2021 16:52:42 -0500
Message-ID: <162949631908.23903.17090272726012848523.stgit@bmoger-ubuntu>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0015.namprd05.prod.outlook.com
 (2603:10b6:803:40::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [127.0.1.1] (165.204.77.1) by SN4PR0501CA0015.namprd05.prod.outlook.com (2603:10b6:803:40::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Fri, 20 Aug 2021 21:52:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 807de455-ea2c-4023-3d17-08d96424d70c
X-MS-TrafficTypeDiagnostic: MW2PR12MB4683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB46836EBB1B71CD166ADA533595C19@MW2PR12MB4683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASxS9d+5n6qj1KkQyaCZe2gr2ApsYft/coFwPL4rcDuCoWn2AieUlEdxZYxnLCTeodF1gsjs5mIyHgaOSGfGry8vxjwRhlRYPEJ/jeod+zO7vCUqXKR4ZZH3WOC+c8erlPG1C/77IXjJkNWQKVodm/rjjqfd77uu/zmPktPYIiHw9/0aWGRe629s3rjAgbe6AwAbFnfHZjOfgWZNDJFc0KPMppNVonEh4cuD86RJzt3NZmRaiZThq+ziLoas1tGEK+bCXULVwJkA4x3CwFfhPNwJTunS2KHSFI9UbZtpm2Oz/JHKxofzg+aqfH1jArE92lUlAfhTPuOMWmRl9UkeqrKezW84b+RIyNVO3MGXti2PFwypxufTfTzEUBjdw53gnHi2xGBVZhKHQ3QvWU9WS2Mbdg8XsqNEWY9DAV/KZi4WWBrYAc8h/TAiBvmSNsORRIg4zp83krGl2DfFIEpF6l8AkmpIRyJCAzM3RQ/9jW8rUH1O5uyJ32vVorEpnPJgvidIw12/moc82CMWvld4aq5EPxKJDCvMqcAcPTFZci8AzffqyWd2ArMVy6mlM+I0tjN2nUibMO2+IcUYgVcuwxSs2Kw4uLuxh1uRL+MhYaFNXC5rDxSEYE0/s6SwFGdjHfrmrYUdL01EkR//1kI58RJvxGNp3cXGuEG+57RjMd8BKpSv9sCUSMw35u18gGrsyWr0Irl5QXakdoSlkOlDw0R4gx7vh2uVnxyCgwXTfz5JOmMqEorZ7n3u03mkRx09+d7MNnv8HvJKHjEG11KffWizZDBKkEHi9lKqTqVNAWL1baIB6zO3k1e7gKK2bk46xfQJ+B85wNCQqWrWLN32jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(39860400002)(396003)(376002)(366004)(346002)(33716001)(66946007)(52116002)(44832011)(5660300002)(956004)(16576012)(186003)(6486002)(966005)(103116003)(66476007)(8936002)(316002)(2906002)(83380400001)(86362001)(26005)(4326008)(38100700002)(38350700002)(478600001)(66556008)(9686003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0Q1dDh1cGJ6YmJjVXZybGhiUGNMMnpycDFoR0hlamM5V3EreWM4dzBHYTAx?=
 =?utf-8?B?NnVEMEhOK1NWcDlvR0E4VTZLd0lMNUpZRWpLU2ZrQm50cXdNbnhWc2FNd2I0?=
 =?utf-8?B?ekMxUkx3d2hIdlc5MXZsQ05qNmVTall3L0pmZVRzYklPaitBcDF3SXJkZ0hR?=
 =?utf-8?B?THl0Wlp4Q0xVRllwb0hZOC80QjQ5NlJBNEdGQ2xLM3BnWC9IN2RnQkM1bEVL?=
 =?utf-8?B?dU5UOW0rVmJnMnJzM1FnQ25VdzhqY1poVWdLZkdoWExRbHJXbHZ3ZW1lamRF?=
 =?utf-8?B?alYxOW5DMG95SDIrZlgxVHZ2dDd5UWdMWWdRMDNZTzdIY1VPUVRWc3lZR3lI?=
 =?utf-8?B?YUJHTWJmdmppdmJyUS8xakpqUWkveUZQR1BkeC83TUkvN1IyOVJwbFBqY24w?=
 =?utf-8?B?SzJGOWM5bm50VWhUZDYxeWFBRG42YWpkS1V4VUhCSGdOYytHNDAycHA5T2lk?=
 =?utf-8?B?VHZEVlNqRjlCaWhwU29Za0JwSjVWbE9XY1o3cFdMWVQyaFdkNTdSS0p6c0dO?=
 =?utf-8?B?MHpPbTRzUzRpaC9zOTNUT05aaFROSnRCb21pYTJuVmtpMjI0TzNxUkZRVm8v?=
 =?utf-8?B?QWQyREFZNHZ4UktVWGh2YlZiRnpncVRWQkJQT2dBNEJCWjJPdUtiQXgxQUlJ?=
 =?utf-8?B?Q3p4ZThWRDVtSlY3K2Q4Q1AvQnJuOGwvSGlVYnhGVUV0L2xIbTM5LzFJSW1F?=
 =?utf-8?B?eklBK3NmUlprUjRSeXZRemhiM1RqdnFPNEZ1TlN1SStxRnB5bjVwTTU3dXE5?=
 =?utf-8?B?SnhrekJNUjdDSDBYcDRkWElkRThDUWJzdHRsZXdjUUhPbUFuS1o4bEMrSDdz?=
 =?utf-8?B?Sy91VnV6S0dWRU9GRk42WVNUaFZ2aDJlRE9WOXI2WDZrLzg4bGM5bkNFcHJM?=
 =?utf-8?B?dGI5TXFzRkFDdy9sOGRKWGljWXBEY1lwcUN6WDJjanQvT1RvY2FtM3pPQ2dB?=
 =?utf-8?B?cTk0SVU1VjBqbEdQdlpZQUhJV1p1Q3VnMk5oTVJPVG1uMER2SU4zN0FrS2cw?=
 =?utf-8?B?cTRTRmdxOUp3K1E1NE9zYXpSVS9lcER0TXQ2TlpNUkdMQnhZVHFBMmNFelBn?=
 =?utf-8?B?STBUL0VlMXJYd29peEpSYXAyaHdjc2hkZXdTU2QwNGt2NGhIOTVnMTE5RGVW?=
 =?utf-8?B?TFVkcXBLcEN5QzV1bVcvaGxMd0lOaVB2c3JzVWNaZTJkTDdXWFFySkg3Qk1G?=
 =?utf-8?B?MzBjZ2dTa3B0Rk1WWWh2bDNQTmR1NHMxRHpjSlV3aXA2a2VIQ3M4dG5sRkU5?=
 =?utf-8?B?bGp6VzZHLzBUSkFVMEN5eFNjckNKRWVORzVTejRCVmZiRGVyYWN3M1AzS2ZM?=
 =?utf-8?B?OUtsZWM4TmpTUTNjZVVJbVBUM0JWdGdDazVQZEUxMDEyZFdLM0owYzg2cGVn?=
 =?utf-8?B?aWgyQ0crRmdES2N5SkVFNnNZVmJLMDZZbVZvSEowNzkzUTc3V1l6VWp2a0E4?=
 =?utf-8?B?ekJNbjg2YXlxQ2grcGw2dEVjMUdUd1JlT3VTMGxYSFlwTHBQN0hoMHpHeU9N?=
 =?utf-8?B?TUFHMFRFNHFvWW11MHM3QlVxSTNDRU5KcnZLc2Foc2JqRHQ0UEcwT2tQWnkw?=
 =?utf-8?B?WlZkdHVSTlBkdm9aWUhtN2s3KzdiVXRvLzk1OTVMcVVwY1Zta3Bma0VtME44?=
 =?utf-8?B?Z3lsQlVlbS8xei8yc0J6MFdFQ2U1QkJkajF3SVhjclhUempKL1Q2REUrNS9h?=
 =?utf-8?B?R1BmU1QxbGFHYk1PSXJqRzE0c0hwZ2xtS29RQ21lRXpuY3lSTktaTGRaQ0Iy?=
 =?utf-8?Q?fQUS5Uh24NRspkJGaaVls8yeeLGwSmfkK2TstZm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807de455-ea2c-4023-3d17-08d96424d70c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 21:52:44.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc0zfgzMXKFaDNr+GTV952h1I7MsQ+CXizxfIXBuEvJ7J8KiWVXF3FLU/80zNwwh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4683
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit 064855a69003 ("x86/resctrl: Fix default monitoring
groups reporting"), caused a RHEL build failure with an uninitialized
variable warning treated as an error. The commit removed the default case
snippet. The RHEL Makefile uses '-Werror=maybe-uninitialized' to force
uninitialized variable warnings to be treated as errors. This is also
reported by kernel test robot. The error from the RHEL build is below:

arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘__mon_event_count’:
arch/x86/kernel/cpu/resctrl/monitor.c:261:12: error: ‘m’ may be used
uninitialized in this function [-Werror=maybe-uninitialized]
  m->chunks += chunks;
            ^~

The upstream Makefile does not build using '-Werror=maybe-uninitialized'.
So, the problem is not seen there. Fix the problem by putting back the
default case snippet.

Fixes: 064855a69003 ("x86/resctrl: Fix default monitoring groups reporting")
Cc: stable@vger.kernel.org
Reported-by: Terry Bowman <Terry.Bowman@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/lkml/6118d218.4ZZRXYKZCzQSq1Km%25lkp@intel.com/

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2:
  Addresed a minor comment about description (Wei Huang).
v1:
  https://lore.kernel.org/lkml/162947718839.12313.2592762168334394449.stgit@bmoger-ubuntu/

 arch/x86/kernel/cpu/resctrl/monitor.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 57e4bb695ff9..8caf871b796f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
 		m = &rr->d->mbm_local[rmid];
 		break;
+	default:
+		/*
+		 * Code would never reach here because an invalid
+		 * event id would fail the __rmid_read.
+		 */
+		return RMID_VAL_ERROR;
 	}
 
 	if (rr->first) {

