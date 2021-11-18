Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485B04561C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhKRRxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:53:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55848 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhKRRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:53:45 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIGra5s000706;
        Thu, 18 Nov 2021 17:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=S5tEkD6mhcePKEmV30HOqzcUe184vxaZq6K69pOltSo=;
 b=XmgKnFCY014ivNennGVDZJATDZZYm6AADNiJOjL64sOc9rSMt5yYAAafmM3bLKFPBMvY
 994aYgcGPe5eIjBk7lv1Cn0RmRHJxXopvN5o/OHyuZ6MYAY7PUxaFTmvb7xfFgUHGHpr
 se8/vc3KP1clnLyIQmzeHGm1oY4y+8Gvl0JpZ8QeKGg1ysIbl8aUwPEkvuz2Mx4jjRgl
 iCk8JX1fjb4+Wrgnw7r0CTtkGhcUmrfJyO59LpnlpAs1grsDyE7e7Ds3b+xJ2wHOpN6b
 tMTQZYKVrf21B+7n6TzBC1xkIXiWtXGFY5+LLRka0Tshecgvn1NriDxkhRZ+19DLRQHn Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd205hh48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHjAm0192530;
        Thu, 18 Nov 2021 17:50:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3caq4we8ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CufnbiiMUxkfzDBpKacg+mZyBF1GfadPMZimsoICl6CBVFHAIcTtybvdOjNjGoiKDr48yweJLAvsLL//4ipfldbRO6GCnAnwonp7KeHyyDP+1ZyJQlhXSy0cpzYeVqG0FEkBQXd6MKLqrGipbFXMAvuPmddTV4zacs7MrrAmsaUFqdJdYaiQdQrf0h6lXAySWMGHk72edXx9q5B844wQbjTT1WwrPl61MfDcmQnJoZpwJMGXA1wLCBgD/+pyWy0dLWtlNtA+u0zxRWDZ8W37idNleQ84v6JRVx1N/1+SETXKeH0m3/bywOYqFWZrs6nIrq/OGsdWkCr01WkWgCw0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5tEkD6mhcePKEmV30HOqzcUe184vxaZq6K69pOltSo=;
 b=XsX3pT9lXsFgEy+ZyiACHsBGzy/49cIu5I8Ap0q2WTWCsaUb6GA2QutsrXWwB9tu9OW89aE7RdhzUyu/RAwYo5/lyyocDSLpY5qx6wbl8gXBHpPfEkH9oKStn+OrWRses2iVt7vb/ZhLOgyWMQKv9xNbXslaX/y+m9eayCq0BCShQQPU95LUnaS5WWMGkaJRqg10IchHGwhbJVH5BH+AsdIVt1B2rUWU5jIVrMbCZABxocYzoAO7UK/r7OCiXKGixqvuwhAo+8eeX6qwIeBlL8/gHmoKQqehGU+pAbvr01t2UNF2Fo0q6bmtv5lVCwOhq87EIIzXCzlqyCyudnh3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5tEkD6mhcePKEmV30HOqzcUe184vxaZq6K69pOltSo=;
 b=bmiDpKAtm/C7lkk8amCXK+I1yCEQbU+LHCSoYobsGgI/oZnqC7nM23F1ErKmVVuLGy/UwICbfGTgqmzocY+PwMQn5OuSzltUAMhdPKdsVJ8fw9BiQmS0IXebk9Zyf9EslGw5BMSdRnCPafroBbjnUbnRh+kxYibdOqKvLNmA+Ek=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR1001MB2061.namprd10.prod.outlook.com (2603:10b6:301:36::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 17:50:05 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:05 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot un/plug for crash
Date:   Thu, 18 Nov 2021 12:49:40 -0500
Message-Id: <20211118174948.37435-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d364327e-b788-444b-1717-08d9aabbda4c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2061:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20616620304D8A3AD2345338979B9@MWHPR1001MB2061.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVCDA7ibYi5dX1LonxSxOx6HgSiN/o7vn2iRvbMOlP9gA58PIeZmvvM2c+ncTgkrIEPmLEZIIK6IWCwSTmEgeHk8wksm8giPw1eV5jiDyDlQ7CrgoEMxsRRUhsCts8ymb/lPmMUXR2E5W62tMfuUH7ptzwlYcbwLpe4qvBTLq2mW0HcmJjvNx8bm6WWFUXzNzm0QNV/rxTBopI24Y6qpbIU0XxM6wbY93OhH/UABGp1lyVz5xTpKJyWk6P8LwOR2MVghcne2fSHBozzxfVgw2lbzRbvyk/1xDIWSeinHLyI5edBL8V8dZ01clWp7VU0+OQzX1yFKZDVAB9rOwLlxDW8LpQzRBdwmYTEP0hr4GQjn0BlyxP9drzqcdfVRrHtrF63+guJ7vrt6FMUazNp/azN3244cquUsVgD8yDsFPIXcNVOH0yRpwG5NMoL1w5T5dLTFqCtMvrdKT0/rtwFw22fIbLVL5RQAnUrEsaWuwwIJTKRYV87FUjNQR38jTv6Yq2gVSMNtDhm1gT4GXK1syMHbKVE8X7NCfRJWc6dJkUk4PIZk6DIvi1v8Gd4/nBdI8dyYEaZwUk+EAa6FCyBK7h7P+nzvbWbCFkr7Y7S7JvMZ83yhF/Z/zlY+aqWzQvK12R2b20uepH2EjZ2C+AIzh3S6R6WEUaRIKKzbDTTbtZz04Iw0HmTZE4BBU7bCLQP4NEz8Om118dqLn/+9dUFa0O16rh4aDJZD9vOmFtpOK37ifI0Fmm2o1P4YrRnmEntkMDHaOlGMgunXngGlnDQe5la+efyRaOlt2W79jRfT0A4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6506007)(2906002)(1076003)(52116002)(6512007)(38350700002)(966005)(36756003)(38100700002)(66556008)(66476007)(107886003)(186003)(4326008)(8936002)(508600001)(7416002)(956004)(26005)(66946007)(5660300002)(316002)(86362001)(83380400001)(2616005)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCenVV4swJXRjFhsgqUdVQV2TWca+uuIsUmysZcXk7Jdrhl3Feu6AuNvOpKA?=
 =?us-ascii?Q?flh/s22P2zeR/ImV9LKeWsPplY17bU8j5omXYW4HezFs4jzq+iY3qDU8Vm4x?=
 =?us-ascii?Q?O9QTAFWI+0FBBtClG3m0IjrxH1Iu45qZzCMhbMqhAH7YreXP/9Ai18xa0FH5?=
 =?us-ascii?Q?hBfKR6phpytsNbe8CYjY6bwtL5lu6DhYuz5KIgZIAIpbQx3qIwqUJJb+qIwR?=
 =?us-ascii?Q?zjekzjQYPW2OAmfTMtwlxP120Jb5ZjLkwfIbPCxaJ0Qmfql+Iqu6/qLY2WIa?=
 =?us-ascii?Q?5aVB7TuoujtwlxnV+z4mu2vufdUKmCIvVlBVCq//9mPrsHbPLignuqtyJu8G?=
 =?us-ascii?Q?O08wj4KeMaqppv46HkaoUP/4DUrFoIIV+TopMMvykRaRV/ucw02DKLY4Khmf?=
 =?us-ascii?Q?CgTlHVSnDm381ulNdmVSHWLIMhO6CyX8q3I/myXo8u67i7hS94+WbY2gtTk0?=
 =?us-ascii?Q?6vr6UhIejOoC4FZ/4iDiG/zhMOfz3CROsKm/Em59rjVnhroxKvyTMbPF3ea4?=
 =?us-ascii?Q?yobSOXxEp6MPjXJv7H5nTkIhCTUJR5ndOKns8DRKhU1bx6/nX8f4vruhKzVg?=
 =?us-ascii?Q?zMiPeHplnSxeIEMD4S0iH9OqQ/bwZ5ytfSEmhJbS5wwc71an5vsQ5f8cWR1c?=
 =?us-ascii?Q?QYAkGYb9ytfleK1gvr7xJK6XMlm+utlO0dyP56fFJRCStKgjCvAwU9FKb4LC?=
 =?us-ascii?Q?A7PprxHiI+/DccFTQ65pz/ZegjPsYIN7AJb1ruxoYSaUZWux6VScI7N08ghz?=
 =?us-ascii?Q?6NUD3eqhXQqOc5+SBqMmzrlyzYBjhr5pYYHWnkFFDM7Nw4qRwX8uVU2ztrQ0?=
 =?us-ascii?Q?eLmEqcvwwosevVk6whfYJYTzaZoMyHgFeGWaU8Cb3fEZSbrDGiSV5vKrVFPk?=
 =?us-ascii?Q?WmhApErUsQvXznkygO8dZqFoIh67zPpgAUbY/YNE7+ykQRbjv7UCMzB2cLQF?=
 =?us-ascii?Q?iRq83cRiQm4std1WGTC4Q9QfOr+Rxrd7u5//gDCaDFJSrJ4BfdC5TR8xuTsK?=
 =?us-ascii?Q?5Jv3O7SJFJJ38RJBRmQHO8NZtoP35jneFuDREoqYyf+s8kidr7yFklKjGBH9?=
 =?us-ascii?Q?JoqMDpkoUwPhNbRiZgd0aFg8y3E+gtjYxQndYiqOL6WtRwLZCkUDATMntBMX?=
 =?us-ascii?Q?E3R6C2EXXopIGHH+SegJ7lv3cK47SafChVMytywGQsG4zWiKVEjc1km0tDAz?=
 =?us-ascii?Q?UfW676FqqJArfJ3xN0qDzxb2uG9Aol9Zt1PCPRMLU11S4j2oG1jdD+puZ3nS?=
 =?us-ascii?Q?zUsPYKGkCUodsGkzVcJHnd1L05VUil5hP/Sq2F5DTwyp1hyBC6suaRP2pk9J?=
 =?us-ascii?Q?74M2f42V7VY83P23KXwtycJU58h+0SthItQqAUzrsoKNehQUeRz78YND7Qhl?=
 =?us-ascii?Q?WaDMDdp09/LxbV4YgA4G/Z8t9ll7kf5BOrEJaCdmBtqOETP0tLVCS+BRKTDy?=
 =?us-ascii?Q?syxpWTg2fC+UkXhily+yfE1LvVsyVwdKmz/CLln9GjEjTKVzZPDLTUKIR3pT?=
 =?us-ascii?Q?1cGfVSXOc+KgqkRkXwg+SxPVl/NjlhlTP3MPmSI8yudd5pk7uC5u8LNxw9V2?=
 =?us-ascii?Q?Wy+Xgs+2fLGDKxiGjB1iVZYXPMp1/QdX4V/4iaQCnRb5uEN0J/cEAM3Ud42H?=
 =?us-ascii?Q?PheyM8sPKlTSXrAc915PedLwaEoYeyYsx57yuHFEBk5gGkUOMOsJOodvBTGk?=
 =?us-ascii?Q?lx/6cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d364327e-b788-444b-1717-08d9aabbda4c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:04.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H63qIddHqm4DZ/Iede268YHcXIa8GxLUmRn8/54nOLDavEaL+AbB12uSQgDUo5xepghS1+CLlt3BcOiMdHLqUufcm1fOL/JpXU7twHDEWYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2061
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-ORIG-GUID: FzoEfDTg3NE-AALa3aceJhA0EUmK7AEQ
X-Proofpoint-GUID: FzoEfDTg3NE-AALa3aceJhA0EUmK7AEQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr which describes the CPUs and memory
in the system, must also be updated, else the resulting vmcore is
inaccurate (eg. missing either CPU context or memory regions).

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (e. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility.

In the post https://lkml.org/lkml/2020/12/14/532 I outlined two
problems with this userspace-initiated unload-then-reload approach as
it pertains to supporting CPU and memory hot un/plug for kdump.
(Note in that post, I erroneously called the elfcorehdr the vmcoreinfo
structure. There is a vmcoreinfo structure, but it has a different
purpose. So in that post substitute "elfcorehdr" for "vmcoreinfo".)

The first problem being the time needed to complete the unload-then-
reload of the kdump image, and the second being the effective race
window that unload-then-reload effort creates.

The scenario I measured was a 32GiB guest being resized to 512GiB and
observing it took over 4 minutes for udev to "settle down" and
complete the unload-then-reload of the resulting 3840 hot plug events.
Empirical evidence within our fleet substantiates this problem.

Each unload-then-reload creates a race window the size of which is the
time it takes to reload the complete kdump image. Within the race
window, kdump is not loaded and should a panic occur, the kernel halts
rather than dumping core via kdump.

This patchset significantly improves upon the current solution by
enabling the kernel to update only the necessary items of the kdump
image. In the case of x86_64, that is just the elfcorehdr and the
purgatory segments. These updates occur as fast as the hot un/plug
events and significantly reduce the size of the race window.

This patchset introduces a generic crash hot un/plug handler that
registers with the CPU and memory notifiers. Upon CPU or memory
changes, this generic handler is invoked and performs important
housekeeping, for example obtaining the appropriate lock, and then
invokes an architecture specific handler to do the appropriate
updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, which reflects the current CPUs and memory regions, into a
buffer. Since purgatory also does an integrity check via hash digests
of the loaded segments, purgatory must also be updated with the new
digests. The arch handler also generates a new purgatory into a
buffer, performs the hash digests of the new memory segments, and then
patches purgatory with the new digests.  If all succeeds, then the
elfcorehdr and purgatory buffers over write the existing buffers and
the new kdump image is live and ready to go. No involvement with
userspace at all.

To accommodate a growing number of resources via hotplug, the
elfcorehdr memory must be sufficiently large enough to accommodate
changes. The CRASH_HOTPLUG_ELFCOREHDR_SZ configure item does just
this.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Disable the udev rule for updating kdump on hot un/plug changes
   Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
   or other technique to neuter the rule.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This work has raised the following questions for me:

First and foremost, this patch only works for the kexec_file_load
syscall path (via "kexec -s -p" utility). The reason being that, for
x86_64 anyway, the purgatory blob provided by userspace can not be
readily decoded in order to update the hash digest. (The
kexec_file_load purgatory is actually a small ELF object with symbols,
so can be patched at run time.) With no way to update purgatory, the
integrity check will always fail and and cause purgatory to hang at
panic time.

That being said, I actually developed this against the kexec_load path
and did have that working by making two one-line changes to userspace
kexec utility: one change that effectively is
CRASH_HOTPLUG_ELFCOREHDR_SZ and the other to disable the integrity
check. But that does not seem to be a long term solution. A possible
long term solution would be to allow the use of the kexec_file_load
purgatory ELF object with the kexec_load path. While I believe that
would work, I am unsure if there are any downsides to doing so.

The second problem is the use of CPUHP_AP_ONLINE_DYN.  The
cpuhp_setup_state_nocalls() is invoked with parameter
CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
the CPU still shows up in foreach_present_cpu() during the
regeneration of the elfcorehdr, thus the need to explicitly check and
exclude the soon-to-be offlined CPU in crash_prepare_elf64_headers().
Perhaps if value(s) new/different than CPUHP_AP_ONLINE_DYN to
cpuhp_setup_state() was utilized, then the offline cpu would no longer
be in foreach_present_cpu(), and this change could be eliminated. I do
not understand cpuhp_setup_state() well enough to choose, or create,
appropriate value(s).

The third problem is the number of memory hot un/plug events.  If, for
example, a 1GiB DIMM is hotplugged, that generate 8 memory events, one
for each 128MiB memblock, yet the walk_system_ram_res() that is used
to obtain the list of memory regions reports the single 1GiB; thus
there are 7 un-necessary trips through this crash hotplug handler.
Perhaps there is another way of handling memory events that would see
the single 1GiB DIMM rather than each memblock?

Regards,
eric

Eric DeVolder (8):
  crash: fix minor typo/bug in debug message
  crash hp: Introduce CRASH_HOTPLUG configuration options
  crash hp: definitions and prototypes for crash hotplug support
  crash hp: generic crash hotplug support infrastructure
  crash hp: kexec_file changes for use by crash hotplug handler
  crash hp: Add x86 crash hotplug state items to kimage
  crash hp: Add x86 crash hotplug support for kexec_file_load
  crash hp: Add x86 crash hotplug support for bzImage

 arch/x86/Kconfig                  |  26 +++
 arch/x86/include/asm/kexec.h      |  10 ++
 arch/x86/kernel/crash.c           | 257 +++++++++++++++++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  12 ++
 include/linux/kexec.h             |  22 ++-
 kernel/crash_core.c               | 118 ++++++++++++++
 kernel/kexec_file.c               |  19 ++-
 7 files changed, 455 insertions(+), 9 deletions(-)

-- 
2.27.0

