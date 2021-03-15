Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1587733B4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCONeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:34:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56950 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCONeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:34:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FDOp5x041823;
        Mon, 15 Mar 2021 13:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VC7iv1ppo+03bRe8wrg+bYyahLQRR7IkOz64wqBL0nw=;
 b=QCY+WKTAFC7EaDjopArYVIdKv4VfnNiBlo+C/weqFCfcbpKp7kGmbTBJ6nYFF5Q0AuUk
 zmp3acYLRQ3xoGomfbojbCzs4v/J6lyhR2tdxOYQzDXQINPFooe3KZrdWAFdKZh7PLxs
 YtYZDKzTG+Um1+JBs6B6UedHjygY0In6fj2xHTIEdvvG3qNYGqIlsBEOF4BHsrBpZ3gv
 EmIDezp6sqEm3YJ2ytuCPvTFw+L37yejoGK4bbdcLjssFycLxespPVJSDYjmZ2myZm4z
 LlF/4V3ukL1BRY/RlOkfLPFA3kVB5EY/meTpvNMuQajppSe7X26pRqV3FggXypE8OqyX pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37a4ekgsbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 13:30:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FDUT0v117017;
        Mon, 15 Mar 2021 13:30:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3796ys3wn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 13:30:33 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12FDUDIF026921;
        Mon, 15 Mar 2021 13:30:16 GMT
Received: from [192.168.1.200] (/108.20.27.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Mar 2021 06:30:12 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] : Re: [LKP] Re: [locking/qspinlock] 0e8d8f4f12:
 stress-ng.zero.ops_per_sec -9.7% regression
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <503790ff-7f97-a3d3-8780-6ebb234efde1@linux.intel.com>
Date:   Mon, 15 Mar 2021 09:30:10 -0400
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "jglauber@marvell.com" <jglauber@marvell.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dave Dice <dave.dice@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D32BF197-B160-42C1-8655-88B66EC87A78@oracle.com>
References: <20201223054455.1990884-4-alex.kogan@oracle.com>
 <20201228081601.GA31221@xsang-OptiPlex-9020>
 <SA2PR10MB46525798D53C47B39F88ED5DF1919@SA2PR10MB4652.namprd10.prod.outlook.com>
 <503790ff-7f97-a3d3-8780-6ebb234efde1@linux.intel.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the update, Xing.

Is there any way for me to reproduce the regression?
Last time I checked the job description file had hardcoded strings to =
identify various components=20
(such as HDD partitions, rootfs partitions, etc).

Regards,
=E2=80=94 Alex

> On Mar 14, 2021, at 10:28 PM, Xing Zhengjun =
<zhengjun.xing@linux.intel.com> wrote:
>=20
>=20
>=20
> On 3/11/2021 1:17 AM, Alex Kogan wrote:
>> [ Looks like my previous reply failed to reach the mailing list. =
Reposting again, after (hopefully)
>> fixing the problem with the included URL. Apologies if you have =
received this message in
>> the past. ]
>>=20
>> A quick update: there is a problem in running this test to reproduce =
the regression,
>> and Oliver Sang is aware of that.
>>=20
>> Along with that, I wonder if this is a real issue or some noise in =
the measurements.
>> This regression is reported with the =E2=80=9C--device" switch, which =
according to
>> =
https://urldefense.com/v3/__https://wiki.ubuntu.com/Kernel/Reference/stres=
s-ng__;!!GqivPVa7Brio!KJgSkso-bLajnACiRoGKa3GJdJO-5X8sZxKAXhK9nojWsD36jGpU=
mgVSNrZtF7-x$ , enables "raw device driver stressors=E2=80=9D.
>> I wonder if it is relevant to the spin lock performance.
>>=20
>> Any thoughts?
>>=20
>> Also, using this opportunity, any further feedback on the patch would =
be greatly appreciated.
>>=20
>> Thanks,
>> =E2=80=94 Alex
>>=20
>=20
> In the previous test, it test by class "device", it includes a lot of =
sub-cases except for "zero", they may affect each other, then I split =
it, only test "zero" test, the test result is as the following, the =
regression still exists.
>=20
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/testtime/class=
/test/cpufreq_governor/ucode/debug-setup:
> =
lkp-ivb-2ep1/stress-ng/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc=
-9/100%/1HDD/30s/device/zero/performance/0x42e/test1
>=20
> commit:
>   cb45bab007ff0cfc42695d055c4b1bf5a5423d81
>   0e8d8f4f1214cfbac219d6917b5f6460f818bb7c
>=20
> cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>   10230669 =C2=B1  2%     -10.7%    9139816 =C2=B1  3%  =
stress-ng.zero.ops
>     341020 =C2=B1  2%     -10.7%     304650 =C2=B1  3% =
stress-ng.zero.ops_per_sec
>=20
>=20
>>=20
>> From: kernel test robot <oliver.sang@intel.com>
>> Sent: Monday, December 28, 2020 3:16 AM
>> To: Alex Kogan <alex.kogan@oracle.com>
>> Cc: 0day robot <lkp@intel.com>; Steven Sistare =
<steven.sistare@oracle.com>; Waiman Long <longman@redhat.com>; LKML =
<linux-kernel@vger.kernel.org>; lkp@lists.01.org <lkp@lists.01.org>; =
ying.huang@intel.com <ying.huang@intel.com>; feng.tang@intel.com =
<feng.tang@intel.com>; zhengjun.xing@intel.com =
<zhengjun.xing@intel.com>; linux@armlinux.org.uk =
<linux@armlinux.org.uk>; peterz@infradead.org <peterz@infradead.org>; =
mingo@redhat.com <mingo@redhat.com>; will.deacon@arm.com =
<will.deacon@arm.com>; arnd@arndb.de <arnd@arndb.de>; =
linux-arch@vger.kernel.org <linux-arch@vger.kernel.org>; =
linux-arm-kernel@lists.infradead.org =
<linux-arm-kernel@lists.infradead.org>; tglx@linutronix.de =
<tglx@linutronix.de>; bp@alien8.de <bp@alien8.de>; hpa@zytor.com =
<hpa@zytor.com>; x86@kernel.org <x86@kernel.org>; guohanjun@huawei.com =
<guohanjun@huawei.com>; jglauber@marvell.com <jglauber@marvell.com>; =
Daniel Jordan <daniel.m.jordan@oracle.com>; Alex Kogan =
<alex.kogan@oracle.com>; Dave Dice <dave.dice@oracle.com>
>> Subject: [locking/qspinlock] 0e8d8f4f12: stress-ng.zero.ops_per_sec =
-9.7% regression
>> =20
>> Greeting,
>>=20
>> FYI, we noticed a -9.7% regression of stress-ng.zero.ops_per_sec due =
to commit:
>>=20
>>=20
>> commit: 0e8d8f4f1214cfbac219d6917b5f6460f818bb7c ("[PATCH v13 3/6] =
locking/qspinlock: Introduce CNA into the slow path of qspinlock")
>> url: =
https://urldefense.com/v3/__https://github.com/0day-ci/linux/commits/Alex-=
Kogan/Add-NUMA-awareness-to-qspinlock/20201223-135025__;!!GqivPVa7Brio!LF1=
Vhc6eU7n1kxGSlPpI_wS0LmREqgH6k1226e4w8C7ug0i7368nCfIT44_wbu1g$
>> base: =
https://urldefense.com/v3/__https://git.kernel.org/cgit/linux/kernel/git/t=
ip/tip.git__;!!GqivPVa7Brio!LF1Vhc6eU7n1kxGSlPpI_wS0LmREqgH6k1226e4w8C7ug0=
i7368nCfIT42aMeOW1$  cb262935a166bdef0ccfe6e2adffa00c0f2d038a
>>=20
>> in testcase: stress-ng
>> on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz =
with 112G memory
>> with following parameters:
>>=20
>>         nr_threads: 100%
>>         disk: 1HDD
>>         testtime: 30s
>>         class: device
>>         cpufreq_governor: performance
>>         ucode: 0x42e
>>=20
>>=20
>> In addition to that, the commit also has significant impact on the =
following tests:
>>=20
>> =
+------------------+------------------------------------------------------=
---------------------+
>> | testcase: change | fsmark: fsmark.files_per_sec 213.9% improvement  =
                         |
>> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ =
2.30GHz with 192G memory |
>> | test parameters  | cpufreq_governor=3Dperformance                   =
                           |
>> |                  | disk=3D1BRD_48G                                  =
                           |
>> |                  | filesize=3D4M                                    =
                           |
>> |                  | fs=3Dbtrfs                                       =
                           |
>> |                  | iterations=3D1x                                  =
                           |
>> |                  | nr_threads=3D64t                                 =
                           |
>> |                  | sync_method=3DNoSync                             =
                           |
>> |                  | test_size=3D24G                                  =
                           |
>> |                  | ucode=3D0x5003003                                =
                           |
>> =
+------------------+------------------------------------------------------=
---------------------+
>> | testcase: change | reaim: reaim.jobs_per_min 96.1% improvement      =
                         |
>> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ =
2.30GHz with 192G memory |
>> | test parameters  | cpufreq_governor=3Dperformance                   =
                           |
>> |                  | nr_task=3D100%                                   =
                           |
>> |                  | runtime=3D300s                                   =
                           |
>> |                  | test=3Dnew_fserver                               =
                           |
>> |                  | ucode=3D0x5003003                                =
                           |
>> =
+------------------+------------------------------------------------------=
---------------------+
>>=20
>>=20
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>=20
>>=20
>> Details are as below:
>> =
--------------------------------------------------------------------------=
------------------------>
>>=20
>>=20
>> To reproduce:
>>=20
>>         git clone =
https://urldefense.com/v3/__https://github.com/intel/lkp-tests.git__;!!Gqi=
vPVa7Brio!LF1Vhc6eU7n1kxGSlPpI_wS0LmREqgH6k1226e4w8C7ug0i7368nCfIT4ySp2S6I=
$
>>         cd lkp-tests
>>         bin/lkp install job.yaml  # job file is attached in this =
email
>>         bin/lkp run     job.yaml
>>=20
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/=
testcase/testtime/ucode:
>>   =
device/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-2020=
0603.cgz/lkp-ivb-2ep1/stress-ng/30s/0x42e
>>=20
>> commit:
>>   cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")
>>   0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of =
qspinlock")
>>=20
>> cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5
>> ---------------- ---------------------------
>>        fail:runs  %reproduction    fail:runs
>>            |             |             |
>>            :4           25%           1:4     =
last_state.is_incomplete_run
>>            :4           25%           1:4     =
dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
>>            :4           25%           1:4     =
dmesg.RIP:smp_call_function_many_cond
>>            :4           25%           1:4     =
dmesg.RIP:smp_call_function_single
>>          %stddev     %change         %stddev
>>              \          |                \
>>     481980 =C2=B1  9%     -12.0%     424197 =C2=B1  5%  =
stress-ng.time.involuntary_context_switches
>>  1.198e+08            -4.0%   1.15e+08        =
stress-ng.time.minor_page_faults
>>     689.06            -4.9%     655.29        =
stress-ng.time.user_time
>>   10626516            -9.7%    9598124        stress-ng.zero.ops
>>     354216            -9.7%     319937        =
stress-ng.zero.ops_per_sec
>>      12871           +19.8%      15424 =C2=B1 12%  =
meminfo.max_used_kB
>>      29.00            +4.6%      30.33        vmstat.cpu.id
>>      29.66            +3.7%      30.75 =C2=B1  2%  iostat.cpu.idle
>>       8.21            -7.6%       7.59 =C2=B1  2%  iostat.cpu.user
>>      67636 =C2=B1 12%     -21.3%      53263 =C2=B1 14%  =
sched_debug.cpu.nr_switches.max
>>      70.29 =C2=B1 16%     -22.1%      54.73 =C2=B1 14%  =
sched_debug.cpu.nr_uninterruptible.stddev
>>       7841 =C2=B1 58%    +418.8%      40676 =C2=B1  2%  =
numa-meminfo.node0.Active
>>       6226 =C2=B1 71%    +542.5%      40001        =
numa-meminfo.node0.Active(anon)
>>      15043 =C2=B1 32%    +271.6%      55899        =
numa-meminfo.node0.Shmem
>>      77673 =C2=B1  3%     -50.0%      38874 =C2=B1  9%  =
numa-meminfo.node1.Active
>>      77439 =C2=B1  3%     -51.0%      37925 =C2=B1  8%  =
numa-meminfo.node1.Active(anon)
>>     233.75 =C2=B1157%    +306.0%     949.00 =C2=B1 66%  =
numa-meminfo.node1.Active(file)
>>     575517 =C2=B1  4%      -8.8%     525050 =C2=B1  3%  =
numa-meminfo.node1.FilePages
>>      87936 =C2=B1  4%     -53.1%      41275 =C2=B1  9%  =
numa-meminfo.node1.Shmem
>>       2097 =C2=B1  5%     +26.8%       2660 =C2=B1 21%  =
slabinfo.dmaengine-unmap-16.active_objs
>>       2097 =C2=B1  5%     +26.8%       2660 =C2=B1 21%  =
slabinfo.dmaengine-unmap-16.num_objs
>>      40336 =C2=B1  6%    +102.0%      81465 =C2=B1 50%  =
slabinfo.filp.active_objs
>>     657.00 =C2=B1  6%     +98.0%       1301 =C2=B1 49%  =
slabinfo.filp.active_slabs
>>      42081 =C2=B1  6%     +97.9%      83296 =C2=B1 49%  =
slabinfo.filp.num_objs
>>     657.00 =C2=B1  6%     +98.0%       1301 =C2=B1 49%  =
slabinfo.filp.num_slabs
>>      13106 =C2=B1  3%     +12.6%      14752 =C2=B1  3%  =
slabinfo.shmem_inode_cache.active_objs
>>      13224 =C2=B1  3%     +12.5%      14873 =C2=B1  3%  =
slabinfo.shmem_inode_cache.num_objs
>>       1557 =C2=B1 71%    +545.2%      10045 =C2=B1  2%  =
numa-vmstat.node0.nr_active_anon
>>     117.50 =C2=B1 57%     -97.4%       3.00 =C2=B1 47%  =
numa-vmstat.node0.nr_mlock
>>       3761 =C2=B1 32%    +273.2%      14037        =
numa-vmstat.node0.nr_shmem
>>       1557 =C2=B1 71%    +545.2%      10045 =C2=B1  2%  =
numa-vmstat.node0.nr_zone_active_anon
>>      19391 =C2=B1  3%     -50.8%       9533 =C2=B1  7%  =
numa-vmstat.node1.nr_active_anon
>>      58.25 =C2=B1157%    +301.1%     233.67 =C2=B1 67%  =
numa-vmstat.node1.nr_active_file
>>     143875 =C2=B1  3%      -8.7%     131291 =C2=B1  3%  =
numa-vmstat.node1.nr_file_pages
>>      21981 =C2=B1  4%     -52.9%      10346 =C2=B1  8%  =
numa-vmstat.node1.nr_shmem
>>      19391 =C2=B1  3%     -50.8%       9533 =C2=B1  7%  =
numa-vmstat.node1.nr_zone_active_anon
>>      58.25 =C2=B1157%    +301.1%     233.67 =C2=B1 67%  =
numa-vmstat.node1.nr_zone_active_file
>>     110768 =C2=B1  3%     -10.6%      99008 =C2=B1  4%  =
softirqs.CPU0.RCU
>>     108763 =C2=B1  3%     -10.1%      97774 =C2=B1  4%  =
softirqs.CPU1.RCU
>>     104199 =C2=B1  3%      -9.5%      94314 =C2=B1  4%  =
softirqs.CPU12.RCU
>>     106156 =C2=B1  5%     -11.6%      93873 =C2=B1  4%  =
softirqs.CPU13.RCU
>>     107231 =C2=B1  4%     -11.3%      95088 =C2=B1  6%  =
softirqs.CPU14.RCU
>>     105547 =C2=B1  5%     -10.5%      94461 =C2=B1  4%  =
softirqs.CPU15.RCU
>>     104326 =C2=B1  5%      -7.4%      96653 =C2=B1  4%  =
softirqs.CPU22.RCU
>>     108301 =C2=B1  3%      -9.9%      97571 =C2=B1  3%  =
softirqs.CPU25.RCU
>>     109423 =C2=B1  3%     -10.9%      97448 =C2=B1  3%  =
softirqs.CPU26.RCU
>>     109554 =C2=B1  4%      -7.2%     101691 =C2=B1  3%  =
softirqs.CPU31.RCU
>>     108410 =C2=B1  4%     -11.2%      96233 =C2=B1  3%  =
softirqs.CPU37.RCU
>>     107189 =C2=B1  4%      -9.8%      96642 =C2=B1  4%  =
softirqs.CPU38.RCU
>>     108943 =C2=B1  4%     -10.9%      97052 =C2=B1  4%  =
softirqs.CPU39.RCU
>>       3348 =C2=B1 37%    +214.8%      10541 =C2=B1 51%  =
softirqs.NET_RX
>>      20942 =C2=B1  2%      -6.2%      19637 =C2=B1  4%  =
proc-vmstat.nr_active_anon
>>      67173 =C2=B1  4%      -3.7%      64699        =
proc-vmstat.nr_anon_pages
>>      10595            -1.7%      10418        proc-vmstat.nr_mapped
>>      25771 =C2=B1  2%      -5.1%      24461 =C2=B1  3%  =
proc-vmstat.nr_shmem
>>      38683            +5.7%      40878 =C2=B1  3%  =
proc-vmstat.nr_slab_unreclaimable
>>      20942 =C2=B1  2%      -6.2%      19637 =C2=B1  4%  =
proc-vmstat.nr_zone_active_anon
>>      21010 =C2=B1 11%     -23.8%      16020 =C2=B1 11%  =
proc-vmstat.numa_hint_faults
>>      16666 =C2=B1 11%     -28.6%      11904 =C2=B1  7%  =
proc-vmstat.numa_hint_faults_local
>>      69020 =C2=B1  3%      -3.7%      66499        =
proc-vmstat.numa_other
>>   21276729            -9.4%   19266740        proc-vmstat.pgactivate
>>      45217            +4.0%      47044        =
proc-vmstat.pgalloc_dma32
>>  1.065e+08            -2.8%  1.035e+08        =
proc-vmstat.pgalloc_normal
>>     610.50 =C2=B1 10%     +83.9%       1123 =C2=B1 28%  =
proc-vmstat.pgdeactivate
>>  1.209e+08            -4.1%  1.159e+08        proc-vmstat.pgfault
>>  1.064e+08            -2.7%  1.035e+08        proc-vmstat.pgfree
>>       5.50 =C2=B1 20%  +71439.4%       3934 =C2=B1141%  =
proc-vmstat.pgmigrate_fail
>>       3540 =C2=B1 29%    +139.9%       8494 =C2=B1  7%  =
proc-vmstat.pgrotated
>>   10600738            -9.5%    9598142        =
proc-vmstat.unevictable_pgs_mlocked
>>   10600295            -9.5%    9598142        =
proc-vmstat.unevictable_pgs_munlocked
>>       0.05 =C2=B1 97%     -59.4%       0.02 =C2=B1  2%  =
perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64=
_after_hwframe.[unknown]
>>       0.03 =C2=B1  6%  +29749.0%       9.03 =C2=B1 71%  =
perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_fr=
om_fork
>>      20.46 =C2=B1  3%      -8.9%      18.64 =C2=B1  4%  =
perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.path=
_openat
>>       7526 =C2=B1 15%     -25.7%       5592 =C2=B1  5%  =
perf-sched.total_wait_and_delay.max.ms
>>       7526 =C2=B1 15%     -25.7%       5592 =C2=B1  5%  =
perf-sched.total_wait_time.max.ms
>>       9.67 =C2=B1168%     -97.6%       0.24 =C2=B1 30%  =
perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.do_=
user_addr_fault.exc_page_fault.asm_exc_page_fault
>>     343.12 =C2=B1139%    +236.4%       1154 =C2=B1 14%  =
perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.gen=
eric_perform_write.__generic_file_write_iter.generic_file_write_iter
>>       1.39 =C2=B1173%  +26107.3%     364.94        =
perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do=
_epoll_wait.__x64_sys_epoll_wait
>>       5.59 =C2=B1  6%     -20.2%       4.46 =C2=B1  6%  =
perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.r=
et_from_fork
>>       1770 =C2=B1  6%     +26.3%       2236 =C2=B1  7%  =
perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.re=
t_from_fork
>>      18.50 =C2=B1 51%    +272.3%      68.88 =C2=B1 22%  =
perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.rem=
ove_vma.__do_munmap.__vm_munmap
>>      20.79 =C2=B1 26%    +217.3%      65.97 =C2=B1  9%  =
perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.unm=
ap_vmas.unmap_region.__do_munmap
>>     242.02 =C2=B1 18%     -60.5%      95.68 =C2=B1 51%  =
perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.r=
et_from_fork
>>       0.12 =C2=B1 32%    +266.9%       0.43 =C2=B1 78%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.alloc_pages_vma.do_anonymous_page
>>       1971 =C2=B1123%     -99.4%      11.34 =C2=B1 10%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.alloc_pages_vma.shmem_alloc_page
>>       9.67 =C2=B1168%     -97.6%       0.24 =C2=B1 30%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.do_user_=
addr_fault.exc_page_fault.asm_exc_page_fault
>>     348.74 =C2=B1136%    +231.0%       1154 =C2=B1 14%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.generic_=
perform_write.__generic_file_write_iter.generic_file_write_iter
>>       5.86 =C2=B1  4%   +1071.7%      68.64 =C2=B1 19%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.khugepag=
ed.kthread.ret_from_fork
>>      38.63 =C2=B1 52%    +843.9%     364.62        =
perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epol=
l_wait.__x64_sys_epoll_wait
>>       5.57 =C2=B1  6%     -20.3%       4.44 =C2=B1  6%  =
perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_fr=
om_fork
>>       1.57 =C2=B1 14%    +683.9%      12.28 =C2=B1100%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.alloc_pages_vma.do_anonymous_page
>>       2468 =C2=B1103%     -99.5%      11.34 =C2=B1 10%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.alloc_pages_vma.shmem_alloc_page
>>       3.91 =C2=B1 14%     -41.4%       2.29 =C2=B1  6%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_rea=
d.__x64_sys_msync.do_syscall_64
>>       7.68 =C2=B1 17%   +1121.8%      93.81 =C2=B1 13%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.khugepag=
ed.kthread.ret_from_fork
>>      18.50 =C2=B1 51%    +272.3%      68.88 =C2=B1 22%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_v=
ma.__do_munmap.__vm_munmap
>>      20.79 =C2=B1 26%    +217.3%      65.97 =C2=B1  9%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unmap_vm=
as.unmap_region.__do_munmap
>>     242.00 =C2=B1 18%     -62.5%      90.66 =C2=B1 61%  =
perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_fr=
om_fork
>>   47358339 =C2=B1  7%     -10.5%   42382902 =C2=B1  2%  =
perf-stat.i.branch-misses
>>   19845519 =C2=B1  2%      -8.5%   18156709 =C2=B1  3%  =
perf-stat.i.cache-misses
>>   1.72e+08            -5.7%  1.621e+08        =
perf-stat.i.cache-references
>>     725.90 =C2=B1  5%     -13.2%     630.12 =C2=B1  5%  =
perf-stat.i.cpu-migrations
>>   3.09e+09            -4.3%  2.957e+09        perf-stat.i.dTLB-stores
>>   19570792            -6.2%   18352176        =
perf-stat.i.iTLB-load-misses
>>      19871 =C2=B1  4%      +9.8%      21819 =C2=B1  3%  =
perf-stat.i.instructions-per-iTLB-miss
>>     382.70            -3.0%     371.36 =C2=B1  2%  =
perf-stat.i.metric.M/sec
>>    7111839 =C2=B1  4%     -11.4%    6302363 =C2=B1  2%  =
perf-stat.i.node-load-misses
>>    8853002 =C2=B1  4%      -9.6%    8004893        =
perf-stat.i.node-loads
>>    6500622            -7.9%    5986359 =C2=B1  4%  =
perf-stat.i.node-store-misses
>>    8596412            -6.5%    8036645 =C2=B1  3%  =
perf-stat.i.node-stores
>>       5.60 =C2=B1  2%      -3.9%       5.38        =
perf-stat.overall.MPKI
>>       0.63 =C2=B1  7%      -0.1        0.57        =
perf-stat.overall.branch-miss-rate%
>>       5180 =C2=B1  2%      +9.2%       5659 =C2=B1  3%  =
perf-stat.overall.cycles-between-cache-misses
>>       1575            +4.8%       1651 =C2=B1  3%  =
perf-stat.overall.instructions-per-iTLB-miss
>>      44.52            -0.5       43.98        =
perf-stat.overall.node-load-miss-rate%
>>      43.02            -0.4       42.61        =
perf-stat.overall.node-store-miss-rate%
>>   47096030 =C2=B1  7%     -11.4%   41713545 =C2=B1  3%  =
perf-stat.ps.branch-misses
>>   19690067 =C2=B1  2%      -9.4%   17836765 =C2=B1  3%  =
perf-stat.ps.cache-misses
>>    1.7e+08 =C2=B1  2%      -6.9%  1.582e+08 =C2=B1  2%  =
perf-stat.ps.cache-references
>>  1.019e+11            -1.1%  1.008e+11        perf-stat.ps.cpu-cycles
>>     748.16 =C2=B1  5%     -11.3%     663.37 =C2=B1  5%  =
perf-stat.ps.cpu-migrations
>>  3.052e+09            -5.5%  2.885e+09 =C2=B1  2%  =
perf-stat.ps.dTLB-stores
>>   19264658            -7.6%   17802646 =C2=B1  2%  =
perf-stat.ps.iTLB-load-misses
>>    7041022 =C2=B1  4%     -12.4%    6164936        =
perf-stat.ps.node-load-misses
>>    8774703 =C2=B1  4%     -10.5%    7851024        =
perf-stat.ps.node-loads
>>    6428583            -9.0%    5851692 =C2=B1  4%  =
perf-stat.ps.node-store-misses
>>    8513354            -7.5%    7878662 =C2=B1  4%  =
perf-stat.ps.node-stores
>>     793.75 =C2=B1  6%     -16.3%     664.33 =C2=B1 12%  =
interrupts.22:IO-APIC.22-fasteoi.ehci_hcd:usb1
>>      10846 =C2=B1 12%     -22.7%       8387 =C2=B1  8%  =
interrupts.CPU0.CAL:Function_call_interrupts
>>       4222 =C2=B1 14%     -49.6%       2128 =C2=B1 43%  =
interrupts.CPU1.NMI:Non-maskable_interrupts
>>       4222 =C2=B1 14%     -49.6%       2128 =C2=B1 43%  =
interrupts.CPU1.PMI:Performance_monitoring_interrupts
>>       3219 =C2=B1 28%     -21.0%       2544 =C2=B1 29%  =
interrupts.CPU10.NMI:Non-maskable_interrupts
>>       3219 =C2=B1 28%     -21.0%       2544 =C2=B1 29%  =
interrupts.CPU10.PMI:Performance_monitoring_interrupts
>>      12387 =C2=B1  8%     -10.7%      11065 =C2=B1 10%  =
interrupts.CPU10.TLB:TLB_shootdowns
>>       3883 =C2=B1 23%     -35.3%       2511 =C2=B1 43%  =
interrupts.CPU11.NMI:Non-maskable_interrupts
>>       3883 =C2=B1 23%     -35.3%       2511 =C2=B1 43%  =
interrupts.CPU11.PMI:Performance_monitoring_interrupts
>>      11453 =C2=B1 37%     -34.1%       7553 =C2=B1 14%  =
interrupts.CPU12.CAL:Function_call_interrupts
>>       2074 =C2=B1126%     -77.6%     464.00 =C2=B1  9%  =
interrupts.CPU12.RES:Rescheduling_interrupts
>>      13347 =C2=B1 59%     -45.5%       7274 =C2=B1 10%  =
interrupts.CPU12.TLB:TLB_shootdowns
>>      11138 =C2=B1 23%     -31.3%       7657 =C2=B1 13%  =
interrupts.CPU13.CAL:Function_call_interrupts
>>       3399 =C2=B1 34%     -29.1%       2410 =C2=B1 50%  =
interrupts.CPU15.NMI:Non-maskable_interrupts
>>       3399 =C2=B1 34%     -29.1%       2410 =C2=B1 50%  =
interrupts.CPU15.PMI:Performance_monitoring_interrupts
>>       3318 =C2=B1 29%     -25.3%       2479 =C2=B1 34%  =
interrupts.CPU16.NMI:Non-maskable_interrupts
>>       3318 =C2=B1 29%     -25.3%       2479 =C2=B1 34%  =
interrupts.CPU16.PMI:Performance_monitoring_interrupts
>>       4574 =C2=B1 17%     -58.7%       1890 =C2=B1 29%  =
interrupts.CPU20.NMI:Non-maskable_interrupts
>>       4574 =C2=B1 17%     -58.7%       1890 =C2=B1 29%  =
interrupts.CPU20.PMI:Performance_monitoring_interrupts
>>       2768 =C2=B1 37%     -44.7%       1531 =C2=B1 30%  =
interrupts.CPU22.NMI:Non-maskable_interrupts
>>       2768 =C2=B1 37%     -44.7%       1531 =C2=B1 30%  =
interrupts.CPU22.PMI:Performance_monitoring_interrupts
>>     516.00 =C2=B1 23%     -18.9%     418.33 =C2=B1  5%  =
interrupts.CPU22.RES:Rescheduling_interrupts
>>       3326 =C2=B1 27%     -28.2%       2387 =C2=B1 34%  =
interrupts.CPU23.NMI:Non-maskable_interrupts
>>       3326 =C2=B1 27%     -28.2%       2387 =C2=B1 34%  =
interrupts.CPU23.PMI:Performance_monitoring_interrupts
>>       3850 =C2=B1 20%     -39.2%       2340 =C2=B1 50%  =
interrupts.CPU25.NMI:Non-maskable_interrupts
>>       3850 =C2=B1 20%     -39.2%       2340 =C2=B1 50%  =
interrupts.CPU25.PMI:Performance_monitoring_interrupts
>>     859.25 =C2=B1 48%     -46.0%     464.33 =C2=B1  5%  =
interrupts.CPU25.RES:Rescheduling_interrupts
>>      13154 =C2=B1 35%     -25.2%       9841 =C2=B1 14%  =
interrupts.CPU25.TLB:TLB_shootdowns
>>       3711 =C2=B1 23%     -45.6%       2018 =C2=B1 45%  =
interrupts.CPU26.NMI:Non-maskable_interrupts
>>       3711 =C2=B1 23%     -45.6%       2018 =C2=B1 45%  =
interrupts.CPU26.PMI:Performance_monitoring_interrupts
>>       4507 =C2=B1  4%     -43.3%       2556 =C2=B1 40%  =
interrupts.CPU27.NMI:Non-maskable_interrupts
>>       4507 =C2=B1  4%     -43.3%       2556 =C2=B1 40%  =
interrupts.CPU27.PMI:Performance_monitoring_interrupts
>>      11363 =C2=B1  9%     -14.9%       9671 =C2=B1  8%  =
interrupts.CPU27.TLB:TLB_shootdowns
>>       4430 =C2=B1  5%     -51.0%       2172 =C2=B1 43%  =
interrupts.CPU28.NMI:Non-maskable_interrupts
>>       4430 =C2=B1  5%     -51.0%       2172 =C2=B1 43%  =
interrupts.CPU28.PMI:Performance_monitoring_interrupts
>>       9512 =C2=B1  3%     -16.7%       7921 =C2=B1  8%  =
interrupts.CPU29.CAL:Function_call_interrupts
>>       3914 =C2=B1 14%     -59.0%       1606 =C2=B1 27%  =
interrupts.CPU29.NMI:Non-maskable_interrupts
>>       3914 =C2=B1 14%     -59.0%       1606 =C2=B1 27%  =
interrupts.CPU29.PMI:Performance_monitoring_interrupts
>>     998.00 =C2=B1 77%     -55.5%     444.00 =C2=B1  2%  =
interrupts.CPU29.RES:Rescheduling_interrupts
>>      11508 =C2=B1 12%     -22.8%       8881 =C2=B1 10%  =
interrupts.CPU29.TLB:TLB_shootdowns
>>       3287 =C2=B1 22%     -36.6%       2082 =C2=B1 43%  =
interrupts.CPU30.NMI:Non-maskable_interrupts
>>       3287 =C2=B1 22%     -36.6%       2082 =C2=B1 43%  =
interrupts.CPU30.PMI:Performance_monitoring_interrupts
>>     571.75 =C2=B1 12%     -21.0%     451.67 =C2=B1 10%  =
interrupts.CPU30.RES:Rescheduling_interrupts
>>      10554 =C2=B1 20%     -26.5%       7757 =C2=B1  6%  =
interrupts.CPU31.CAL:Function_call_interrupts
>>       3521 =C2=B1 21%     -47.8%       1838 =C2=B1  9%  =
interrupts.CPU31.NMI:Non-maskable_interrupts
>>       3521 =C2=B1 21%     -47.8%       1838 =C2=B1  9%  =
interrupts.CPU31.PMI:Performance_monitoring_interrupts
>>     604.00 =C2=B1 20%     -26.0%     447.00 =C2=B1 14%  =
interrupts.CPU31.RES:Rescheduling_interrupts
>>       3946 =C2=B1 21%     -51.9%       1898 =C2=B1  6%  =
interrupts.CPU32.NMI:Non-maskable_interrupts
>>       3946 =C2=B1 21%     -51.9%       1898 =C2=B1  6%  =
interrupts.CPU32.PMI:Performance_monitoring_interrupts
>>       2221 =C2=B1 74%     -74.2%     573.00 =C2=B1 13%  =
interrupts.CPU32.RES:Rescheduling_interrupts
>>       2969 =C2=B1 22%     -40.2%       1774 =C2=B1 11%  =
interrupts.CPU33.NMI:Non-maskable_interrupts
>>       2969 =C2=B1 22%     -40.2%       1774 =C2=B1 11%  =
interrupts.CPU33.PMI:Performance_monitoring_interrupts
>>      13653 =C2=B1 16%     -40.8%       8079 =C2=B1  6%  =
interrupts.CPU34.CAL:Function_call_interrupts
>>       3074 =C2=B1 20%     -41.7%       1791 =C2=B1 18%  =
interrupts.CPU34.NMI:Non-maskable_interrupts
>>       3074 =C2=B1 20%     -41.7%       1791 =C2=B1 18%  =
interrupts.CPU34.PMI:Performance_monitoring_interrupts
>>      18328 =C2=B1 31%     -48.1%       9519 =C2=B1  7%  =
interrupts.CPU34.TLB:TLB_shootdowns
>>      11937 =C2=B1 21%     -36.1%       7623 =C2=B1 15%  =
interrupts.CPU35.CAL:Function_call_interrupts
>>       3503 =C2=B1 30%     -36.4%       2229 =C2=B1 12%  =
interrupts.CPU35.NMI:Non-maskable_interrupts
>>       3503 =C2=B1 30%     -36.4%       2229 =C2=B1 12%  =
interrupts.CPU35.PMI:Performance_monitoring_interrupts
>>      16203 =C2=B1 41%     -47.9%       8444 =C2=B1 15%  =
interrupts.CPU35.TLB:TLB_shootdowns
>>       4311 =C2=B1 20%     -43.4%       2440 =C2=B1 50%  =
interrupts.CPU37.NMI:Non-maskable_interrupts
>>       4311 =C2=B1 20%     -43.4%       2440 =C2=B1 50%  =
interrupts.CPU37.PMI:Performance_monitoring_interrupts
>>       1028 =C2=B1 98%     -60.6%     404.67 =C2=B1  5%  =
interrupts.CPU37.RES:Rescheduling_interrupts
>>      11376 =C2=B1 22%     -35.6%       7324 =C2=B1  2%  =
interrupts.CPU37.TLB:TLB_shootdowns
>>       3390 =C2=B1 35%     -35.8%       2177 =C2=B1 50%  =
interrupts.CPU38.NMI:Non-maskable_interrupts
>>       3390 =C2=B1 35%     -35.8%       2177 =C2=B1 50%  =
interrupts.CPU38.PMI:Performance_monitoring_interrupts
>>       2077 =C2=B1133%     -80.7%     401.33 =C2=B1 12%  =
interrupts.CPU38.RES:Rescheduling_interrupts
>>       3760 =C2=B1 19%     -54.3%       1716 =C2=B1 66%  =
interrupts.CPU39.NMI:Non-maskable_interrupts
>>       3760 =C2=B1 19%     -54.3%       1716 =C2=B1 66%  =
interrupts.CPU39.PMI:Performance_monitoring_interrupts
>>       3338 =C2=B1 68%     -85.1%     496.67 =C2=B1 17%  =
interrupts.CPU4.RES:Rescheduling_interrupts
>>       3731 =C2=B1 27%     -45.6%       2030 =C2=B1 38%  =
interrupts.CPU40.NMI:Non-maskable_interrupts
>>       3731 =C2=B1 27%     -45.6%       2030 =C2=B1 38%  =
interrupts.CPU40.PMI:Performance_monitoring_interrupts
>>       4265 =C2=B1  5%     -43.5%       2409 =C2=B1 45%  =
interrupts.CPU42.NMI:Non-maskable_interrupts
>>       4265 =C2=B1  5%     -43.5%       2409 =C2=B1 45%  =
interrupts.CPU42.PMI:Performance_monitoring_interrupts
>>       3425 =C2=B1 18%     -41.4%       2007 =C2=B1 51%  =
interrupts.CPU43.NMI:Non-maskable_interrupts
>>       3425 =C2=B1 18%     -41.4%       2007 =C2=B1 51%  =
interrupts.CPU43.PMI:Performance_monitoring_interrupts
>>     627.00 =C2=B1 46%     -43.4%     354.67 =C2=B1  2%  =
interrupts.CPU43.RES:Rescheduling_interrupts
>>       4679 =C2=B1 13%     -71.6%       1331 =C2=B1 21%  =
interrupts.CPU44.NMI:Non-maskable_interrupts
>>       4679 =C2=B1 13%     -71.6%       1331 =C2=B1 21%  =
interrupts.CPU44.PMI:Performance_monitoring_interrupts
>>     494.50 =C2=B1 18%     -25.8%     367.00 =C2=B1 15%  =
interrupts.CPU44.RES:Rescheduling_interrupts
>>       3975 =C2=B1 18%     -43.4%       2249 =C2=B1 46%  =
interrupts.CPU45.NMI:Non-maskable_interrupts
>>       3975 =C2=B1 18%     -43.4%       2249 =C2=B1 46%  =
interrupts.CPU45.PMI:Performance_monitoring_interrupts
>>       8711 =C2=B1  9%     -11.6%       7705        =
interrupts.CPU46.CAL:Function_call_interrupts
>>       3650 =C2=B1 22%     -44.9%       2010 =C2=B1 55%  =
interrupts.CPU46.NMI:Non-maskable_interrupts
>>       3650 =C2=B1 22%     -44.9%       2010 =C2=B1 55%  =
interrupts.CPU46.PMI:Performance_monitoring_interrupts
>>     440.75 =C2=B1  9%     -16.7%     367.00 =C2=B1  7%  =
interrupts.CPU46.RES:Rescheduling_interrupts
>>       7891 =C2=B1 10%     -25.7%       5860 =C2=B1 11%  =
interrupts.CPU47.CAL:Function_call_interrupts
>>     793.00 =C2=B1 40%     -50.6%     392.00 =C2=B1  3%  =
interrupts.CPU47.RES:Rescheduling_interrupts
>>       2663 =C2=B1 23%     -21.6%       2087 =C2=B1  7%  =
interrupts.CPU5.NMI:Non-maskable_interrupts
>>       2663 =C2=B1 23%     -21.6%       2087 =C2=B1  7%  =
interrupts.CPU5.PMI:Performance_monitoring_interrupts
>>      12129 =C2=B1 30%     -32.7%       8164 =C2=B1  2%  =
interrupts.CPU7.CAL:Function_call_interrupts
>>      14622 =C2=B1 38%     -33.7%       9701 =C2=B1  6%  =
interrupts.CPU7.TLB:TLB_shootdowns
>>     793.75 =C2=B1  6%     -16.3%     664.33 =C2=B1 12%  =
interrupts.CPU8.22:IO-APIC.22-fasteoi.ehci_hcd:usb1
>>       2516 =C2=B1  7%     +26.7%       3188 =C2=B1 15%  =
interrupts.CPU8.NMI:Non-maskable_interrupts
>>       2516 =C2=B1  7%     +26.7%       3188 =C2=B1 15%  =
interrupts.CPU8.PMI:Performance_monitoring_interrupts
>>       1784 =C2=B1 54%     -58.8%     735.00 =C2=B1  4%=EF=BF=BD=EF=BF=BD=
 interrupts.CPU8.RES:Rescheduling_interrupts
>>     656.75 =C2=B1 18%     +51.0%     992.00 =C2=B1 20%  =
interrupts.CPU9.RES:Rescheduling_interrupts
>>     168231 =C2=B1  7%     -33.4%     112034 =C2=B1 19%  =
interrupts.NMI:Non-maskable_interrupts
>>     168231 =C2=B1  7%     -33.4%     112034 =C2=B1 19%  =
interrupts.PMI:Performance_monitoring_interrupts
>>       7.01 =C2=B1 14%      -3.4        3.60 =C2=B1 50%  =
perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_6=
4_after_hwframe
>>       4.21 =C2=B1 21%      -1.9        2.29 =C2=B1 63%  =
perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to=
_user_mode.entry_SYSCALL_64_after_hwframe
>>       2.84 =C2=B1 12%      -1.9        0.96 =C2=B1 39%  =
perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
>>       4.06 =C2=B1 21%      -1.8        2.23 =C2=B1 65%  =
perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.s=
yscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>>       2.64 =C2=B1 13%      -1.8        0.87 =C2=B1 40%  =
perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_=
64.entry_SYSCALL_64_after_hwframe
>>       3.84 =C2=B1 22%      -1.7        2.13 =C2=B1 67%  =
perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_pr=
epare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>>       1.49 =C2=B1  7%      -0.9        0.54 =C2=B1 70%  =
perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open=
.do_sys_openat2.do_sys_open
>>       1.46 =C2=B1  8%      -0.9        0.53 =C2=B1 70%  =
perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat=
.do_filp_open.do_sys_openat2
>>       1.28 =C2=B1  5%      -0.8        0.51 =C2=B1 71%  =
perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
>>       1.06 =C2=B1  6%      -0.6        0.42 =C2=B1 71%  =
perf-profile.calltrace.cycles-pp.__entry_text_start
>>       0.77 =C2=B1 13%      +0.3        1.05 =C2=B1 11%  =
perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_ap=
ic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
>>       0.82 =C2=B1 12%      +0.3        1.12 =C2=B1 11%  =
perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_e=
nter_state.cpuidle_enter.do_idle.cpu_startup_entry
>>       1.23 =C2=B1 13%      +0.4        1.68 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar=
.uart_console_write.serial8250_console_write.console_unlock
>>       1.23 =C2=B1 13%      +0.4        1.68 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_w=
rite.serial8250_console_write.console_unlock.vprintk_emit
>>       1.82 =C2=B1 13%      +0.6        2.39 =C2=B1 17%  =
perf-profile.calltrace.cycles-pp.create_basic_memory_bitmaps.snapshot_open=
.misc_open.chrdev_open.do_dentry_open
>>       0.00            +0.6        0.61 =C2=B1 12%  =
perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sy=
svec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.=
cpuidle_enter_state
>>       0.00            +0.6        0.62 =C2=B1 12%  =
perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_time=
r_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_en=
ter
>>       4.96 =C2=B1  7%      +1.7        6.69 =C2=B1 19%  =
perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.misc_ope=
n.chrdev_open.do_dentry_open
>>       7.19 =C2=B1 14%      -3.4        3.78 =C2=B1 45%  =
perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>>       3.03 =C2=B1 53%      -2.8        0.24 =C2=B1 21%  =
perf-profile.children.cycles-pp.link_path_walk
>>       4.28 =C2=B1 21%      -1.9        2.35 =C2=B1 61%  =
perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>>       2.85 =C2=B1 12%      -1.9        0.96 =C2=B1 40%  =
perf-profile.children.cycles-pp.ksys_mmap_pgoff
>>       4.26 =C2=B1 21%      -1.9        2.38 =C2=B1 62%  =
perf-profile.children.cycles-pp.task_work_run
>>       2.65 =C2=B1 13%      -1.8        0.88 =C2=B1 40%  =
perf-profile.children.cycles-pp.vm_mmap_pgoff
>>       4.04 =C2=B1 22%      -1.8        2.27 =C2=B1 64%  =
perf-profile.children.cycles-pp.__fput
>>       1.69 =C2=B1 54%      -1.6        0.13 =C2=B1 22%  =
perf-profile.children.cycles-pp.inode_permission
>>       1.47 =C2=B1 51%      -1.3        0.16 =C2=B1  3%  =
perf-profile.children.cycles-pp.walk_component
>>       1.33 =C2=B1 54%      -1.2        0.11 =C2=B1 14%  =
perf-profile.children.cycles-pp.lookup_fast
>>       1.49 =C2=B1 27%      -1.1        0.36 =C2=B1 28%  =
perf-profile.children.cycles-pp._raw_spin_lock
>>       1.49 =C2=B1 31%      -1.1        0.40 =C2=B1 48%  =
perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>>       1.51 =C2=B1 21%      -1.1        0.44 =C2=B1 53%  =
perf-profile.children.cycles-pp.down_write_killable
>>       0.91 =C2=B1 62%      -0.9        0.04 =C2=B1 71%  =
perf-profile.children.cycles-pp.hidraw_release
>>       1.58 =C2=B1  8%      -0.8        0.73 =C2=B1 24%  =
perf-profile.children.cycles-pp.alloc_empty_file
>>       1.55 =C2=B1  9%      -0.8        0.72 =C2=B1 24%  =
perf-profile.children.cycles-pp.__alloc_file
>>       1.49 =C2=B1  5%      -0.7        0.74 =C2=B1 28%  =
perf-profile.children.cycles-pp.syscall_return_via_sysret
>>       1.26 =C2=B1  6%      -0.6        0.63 =C2=B1 27%  =
perf-profile.children.cycles-pp.__entry_text_start
>>       1.12 =C2=B1  9%      -0.6        0.55 =C2=B1 24%  =
perf-profile.children.cycles-pp.kmem_cache_alloc
>>       0.87 =C2=B1 18%      -0.6        0.31 =C2=B1 34%  =
perf-profile.children.cycles-pp.do_mmap
>>       0.63 =C2=B1  7%      -0.4        0.22 =C2=B1 25%  =
perf-profile.children.cycles-pp.dput
>>       0.55 =C2=B1 17%      -0.4        0.15 =C2=B1 34%  =
perf-profile.children.cycles-pp.security_file_open
>>       0.53 =C2=B1 19%      -0.4        0.14 =C2=B1 36%  =
perf-profile.children.cycles-pp.apparmor_file_open
>>       0.52 =C2=B1 32%      -0.4        0.14 =C2=B1 55%  =
perf-profile.children.cycles-pp.rwsem_spin_on_owner
>>       0.48 =C2=B1 22%      -0.4        0.12 =C2=B1 13%  =
perf-profile.children.cycles-pp.ima_file_check
>>       0.65 =C2=B1  7%      -0.4        0.29 =C2=B1 35%  =
perf-profile.children.cycles-pp.__x64_sys_select
>>       0.47 =C2=B1 23%      -0.4        0.11 =C2=B1 14%  =
perf-profile.children.cycles-pp.security_task_getsecid
>>       0.64 =C2=B1  7%      -0.4        0.29 =C2=B1 35%  =
perf-profile.children.cycles-pp.kern_select
>>       0.62 =C2=B1 13%      -0.3        0.27 =C2=B1 36%  =
perf-profile.children.cycles-pp.__x64_sys_exit_group
>>       0.62 =C2=B1 12%      -0.3        0.28 =C2=B1 33%  =
perf-profile.children.cycles-pp.do_group_exit
>>       0.62 =C2=B1 12%      -0.3        0.28 =C2=B1 33%  =
perf-profile.children.cycles-pp.do_exit
>>       0.45 =C2=B1 24%      -0.3        0.11 =C2=B1 19%  =
perf-profile.children.cycles-pp.apparmor_task_getsecid
>>       0.49 =C2=B1 65%      -0.3        0.16 =C2=B1 83%  =
perf-profile.children.cycles-pp.__x64_sys_munmap
>>       0.49 =C2=B1 64%      -0.3        0.16 =C2=B1 83%  =
perf-profile.children.cycles-pp.__vm_munmap
>>       0.48 =C2=B1  5%      -0.3        0.16 =C2=B1 34%  =
perf-profile.children.cycles-pp.lockref_put_or_lock
>>       0.51 =C2=B1  9%      -0.3        0.19 =C2=B1 15%  =
perf-profile.children.cycles-pp.security_file_alloc
>>       0.51 =C2=B1  7%      -0.3        0.20 =C2=B1 38%  =
perf-profile.children.cycles-pp.__x64_sys_close
>>       0.59 =C2=B1 12%      -0.3        0.30 =C2=B1 13%  =
perf-profile.children.cycles-pp.__do_sys_clone
>>       0.59 =C2=B1 12%      -0.3        0.30 =C2=B1 13%  =
perf-profile.children.cycles-pp.kernel_clone
>>       0.41 =C2=B1 11%      -0.3        0.13 =C2=B1 18%  =
perf-profile.children.cycles-pp.apparmor_file_alloc_security
>>       0.57 =C2=B1 12%      -0.3        0.29 =C2=B1 12%  =
perf-profile.children.cycles-pp.copy_process
>>       0.51 =C2=B1  8%      -0.3        0.23 =C2=B1 38%  =
perf-profile.children.cycles-pp.core_sys_select
>>       0.43 =C2=B1 14%      -0.3        0.17 =C2=B1 14%  =
perf-profile.children.cycles-pp.mmput
>>       0.43 =C2=B1 14%      -0.3        0.17 =C2=B1 14%  =
perf-profile.children.cycles-pp.exit_mmap
>>       0.45 =C2=B1  8%      -0.3        0.19 =C2=B1 35%  =
perf-profile.children.cycles-pp.get_unmapped_area
>>       0.40 =C2=B1 17%      -0.3        0.14 =C2=B1 20%  =
perf-profile.children.cycles-pp.__do_sys_newfstat
>>       0.50 =C2=B1 13%      -0.2        0.26 =C2=B1 12%  =
perf-profile.children.cycles-pp.dup_mm
>>       0.71 =C2=B1  9%      -0.2        0.48 =C2=B1 11%  =
perf-profile.children.cycles-pp.do_softirq_own_stack
>>       0.75 =C2=B1 10%      -0.2        0.52 =C2=B1 11%  =
perf-profile.children.cycles-pp.irq_exit_rcu
>>       0.49 =C2=B1 12%      -0.2        0.26 =C2=B1 12%  =
perf-profile.children.cycles-pp.dup_mmap
>>       0.41 =C2=B1  9%      -0.2        0.19 =C2=B1 36%  =
perf-profile.children.cycles-pp.__fget_files
>>       0.28 =C2=B1 52%      -0.2        0.06 =C2=B1 75%  =
perf-profile.children.cycles-pp.mmap_region
>>       0.35 =C2=B1  5%      -0.2        0.14 =C2=B1 34%  =
perf-profile.children.cycles-pp.security_mmap_file
>>       0.39 =C2=B1  7%      -0.2        0.18 =C2=B1 15%  =
perf-profile.children.cycles-pp.getname_flags
>>       0.32 =C2=B1  7%      -0.2        0.12 =C2=B1 35%  =
perf-profile.children.cycles-pp.complete_walk
>>       0.32 =C2=B1  7%      -0.2        0.12 =C2=B1 31%  =
perf-profile.children.cycles-pp.unlazy_walk
>>       0.29 =C2=B1 22%      -0.2        0.09 =C2=B1 27%  =
perf-profile.children.cycles-pp.vfs_fstat
>>       0.30 =C2=B1 17%      -0.2        0.10 =C2=B1 12%  =
perf-profile.children.cycles-pp.security_file_free
>>       0.28 =C2=B1 21%      -0.2        0.08 =C2=B1 14%  =
perf-profile.children.cycles-pp.aa_get_task_label
>>       0.29 =C2=B1 17%      -0.2        0.09 =C2=B1 14%  =
perf-profile.children.cycles-pp.apparmor_file_free_security
>>       0.25 =C2=B1 32%      -0.2        0.06 =C2=B1 13%  =
perf-profile.children.cycles-pp.step_into
>>       0.36 =C2=B1 10%      -0.2        0.17 =C2=B1 39%  =
perf-profile.children.cycles-pp.do_select
>>       0.33 =C2=B1  7%      -0.2        0.14 =C2=B1 34%  =
perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
>>       0.29 =C2=B1  7%      -0.2        0.10 =C2=B1 31%  =
perf-profile.children.cycles-pp.__legitimize_path
>>       0.36 =C2=B1 17%      -0.2        0.17 =C2=B1  7%  =
perf-profile.children.cycles-pp.__schedule
>>       0.29 =C2=B1  8%      -0.2        0.11 =C2=B1 40%  =
perf-profile.children.cycles-pp.terminate_walk
>>       0.34 =C2=B1  8%      -0.2        0.17 =C2=B1 34%  =
perf-profile.children.cycles-pp.__fget_light
>>       0.25 =C2=B1 25%      -0.2        0.08 =C2=B1 24%  =
perf-profile.children.cycles-pp.may_open
>>       0.25 =C2=B1 18%      -0.2        0.08 =C2=B1 35%  =
perf-profile.children.cycles-pp.mutex_lock
>>       0.35 =C2=B1  7%      -0.2        0.18 =C2=B1 50%  =
perf-profile.children.cycles-pp.__alloc_pages_nodemask
>>       0.39 =C2=B1 13%      -0.2        0.22 =C2=B1 24%  =
perf-profile.children.cycles-pp.ksys_lseek
>>       0.25 =C2=B1 58%      -0.2        0.09 =C2=B1 84%  =
perf-profile.children.cycles-pp.__do_munmap
>>       0.22 =C2=B1  8%      -0.2        0.06 =C2=B1 71%  =
perf-profile.children.cycles-pp.lockref_get_not_dead
>>       0.21 =C2=B1 17%      -0.2        0.06 =C2=B1 75%  =
perf-profile.children.cycles-pp.cdev_put
>>       0.25 =C2=B1 10%      -0.2        0.10 =C2=B1 38%  =
perf-profile.children.cycles-pp.__close_fd
>>       0.24 =C2=B1 10%      -0.1        0.10 =C2=B1 38%  =
perf-profile.children.cycles-pp.pick_file
>>       0.37 =C2=B1 10%      -0.1        0.23 =C2=B1 12%  =
perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>>       0.27 =C2=B1  9%      -0.1        0.13 =C2=B1 33%  =
perf-profile.children.cycles-pp.__alloc_fd
>>       0.21 =C2=B1 23%      -0.1        0.07 =C2=B1 20%  =
perf-profile.children.cycles-pp.free_pgtables
>>       0.27 =C2=B1 20%      -0.1        0.13 =C2=B1  9%  =
perf-profile.children.cycles-pp.schedule
>>       0.26 =C2=B1  7%      -0.1        0.12 =C2=B1 18%  =
perf-profile.children.cycles-pp.strncpy_from_user
>>       0.23 =C2=B1 10%      -0.1        0.09 =C2=B1 39%  =
perf-profile.children.cycles-pp.filp_close
>>       0.20 =C2=B1 11%      -0.1        0.07 =C2=B1 71%  =
perf-profile.children.cycles-pp.vm_unmapped_area
>>       0.25 =C2=B1  4%      -0.1        0.12 =C2=B1 29%  =
perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>>       0.17 =C2=B1 16%      -0.1        0.04 =C2=B1 76%  =
perf-profile.children.cycles-pp.kobject_put
>>       0.19 =C2=B1 19%      -0.1        0.06 =C2=B1 29%  =
perf-profile.children.cycles-pp.copy_page_range
>>       0.22 =C2=B1 11%      -0.1        0.10 =C2=B1 14%  =
perf-profile.children.cycles-pp.try_to_wake_up
>>       0.21 =C2=B1  9%      -0.1        0.08 =C2=B1 34%  =
perf-profile.children.cycles-pp.common_file_perm
>>       0.22 =C2=B1 10%      -0.1        0.10 =C2=B1 32%  =
perf-profile.children.cycles-pp.fput_many
>>       0.29 =C2=B1 21%      -0.1        0.17 =C2=B1 47%  =
perf-profile.children.cycles-pp.drm_release
>>       0.29 =C2=B1 21%      -0.1        0.17 =C2=B1 47%  =
perf-profile.children.cycles-pp.drm_client_dev_restore
>>       0.29 =C2=B1 21%      -0.1        0.17 =C2=B1 47%  =
perf-profile.children.cycles-pp.drm_fbdev_client_restore
>>       0.29 =C2=B1 21%      -0.1        0.17 =C2=B1 47%  =
perf-profile.children.cycles-pp.__drm_fb_helper_restore_fbdev_mode_unlocke=
d
>>       0.29 =C2=B1 21%      -0.1        0.17 =C2=B1 47%  =
perf-profile.children.cycles-pp.drm_client_modeset_commit
>>       0.29 =C2=B1 21%      -0.1        0.17 =C2=B1 47%  =
perf-profile.children.cycles-pp.drm_client_modeset_commit_locked
>>       0.29 =C2=B1 21%      -0.1        0.17 =C2=B1 47%  =
perf-profile.children.cycles-pp.drm_client_modeset_commit_atomic
>>       0.28 =C2=B1  4%      -0.1        0.16 =C2=B1 48%  =
perf-profile.children.cycles-pp.get_page_from_freelist
>>       0.20 =C2=B1 15%      -0.1        0.08 =C2=B1 30%  =
perf-profile.children.cycles-pp.unmap_vmas
>>       0.16 =C2=B1 21%      -0.1        0.04 =C2=B1 76%  =
perf-profile.children.cycles-pp.copy_pte_range
>>       0.18 =C2=B1  9%      -0.1        0.07 =C2=B1 71%  =
perf-profile.children.cycles-pp.__x64_sys_fcntl
>>       0.22 =C2=B1  7%      -0.1        0.10 =C2=B1 36%  =
perf-profile.children.cycles-pp.__x64_sys_poll
>>       0.22 =C2=B1  7%      -0.1        0.10 =C2=B1  9%  =
perf-profile.children.cycles-pp.__check_object_size
>>       0.18 =C2=B1 12%      -0.1        0.07 =C2=B1 25%  =
perf-profile.children.cycles-pp.unmap_page_range
>>       0.20 =C2=B1  8%      -0.1        0.09 =C2=B1 33%  =
perf-profile.children.cycles-pp.do_sys_poll
>>       0.15 =C2=B1  7%      -0.1        0.05 =C2=B1 72%  =
perf-profile.children.cycles-pp.__might_sleep
>>       0.15 =C2=B1  8%      -0.1        0.05 =C2=B1 78%  =
perf-profile.children.cycles-pp.obj_cgroup_charge
>>       0.15 =C2=B1  9%      -0.1        0.06 =C2=B1 16%  =
perf-profile.children.cycles-pp.zap_pte_range
>>       0.17 =C2=B1 20%      -0.1        0.07 =C2=B1 72%  =
perf-profile.children.cycles-pp.__slab_alloc
>>       0.16 =C2=B1 22%      -0.1        0.07 =C2=B1 72%  =
perf-profile.children.cycles-pp.___slab_alloc
>>       0.14 =C2=B1 19%      -0.1        0.04 =C2=B1 71%  =
perf-profile.children.cycles-pp.unlink_anon_vmas
>>       0.17 =C2=B1 38%      -0.1        0.07 =C2=B1 74%  =
perf-profile.children.cycles-pp.block_ioctl
>>       0.16 =C2=B1  9%      -0.1        0.07 =C2=B1 20%  =
perf-profile.children.cycles-pp.anon_vma_fork
>>       0.18 =C2=B1  5%      -0.1        0.09 =C2=B1 18%  =
perf-profile.children.cycles-pp.___might_sleep
>>       0.14 =C2=B1 32%      -0.1        0.05 =C2=B1 81%  =
perf-profile.children.cycles-pp.drm_stub_open
>>       0.14 =C2=B1 32%      -0.1        0.05 =C2=B1 81%  =
perf-profile.children.cycles-pp.drm_open
>>       0.14 =C2=B1 32%      -0.1        0.05 =C2=B1 81%  =
perf-profile.children.cycles-pp.drm_master_open
>>       0.16 =C2=B1  9%      -0.1        0.07 =C2=B1 23%  =
perf-profile.children.cycles-pp.get_obj_cgroup_from_current
>>       0.16 =C2=B1 38%      -0.1        0.07 =C2=B1 74%  =
perf-profile.children.cycles-pp.blkdev_ioctl
>>       0.12 =C2=B1 12%      -0.1        0.04 =C2=B1 71%  =
perf-profile.children.cycles-pp._cond_resched
>>       0.12 =C2=B1  8%      -0.1        0.04 =C2=B1 73%  =
perf-profile.children.cycles-pp.memset_erms
>>       0.14 =C2=B1 25%      -0.1        0.06 =C2=B1 72%  =
perf-profile.children.cycles-pp.allocate_slab
>>       0.12 =C2=B1 13%      -0.1        0.04 =C2=B1 71%  =
perf-profile.children.cycles-pp.call_rcu
>>       0.17 =C2=B1 25%      -0.1        0.09 =C2=B1 50%  =
perf-profile.children.cycles-pp.path_lookupat
>>       0.17 =C2=B1 30%      -0.1        0.10 =C2=B1 61%  =
perf-profile.children.cycles-pp.__fxstat64
>>       0.11 =C2=B1 12%      -0.1        0.03 =C2=B1 70%  =
perf-profile.children.cycles-pp.anon_vma_clone
>>       0.11 =C2=B1 10%      -0.1        0.03 =C2=B1 70%  =
perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>>       0.15 =C2=B1 16%      -0.1        0.08 =C2=B1 10%  =
perf-profile.children.cycles-pp.pick_next_task_fair
>>       0.14 =C2=B1  6%      -0.1        0.07 =C2=B1 11%  =
perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>>       0.10 =C2=B1 12%      -0.1        0.03 =C2=B1 70%  =
perf-profile.children.cycles-pp.cp_new_stat
>>       0.13 =C2=B1 10%      -0.1        0.06 =C2=B1 19%  =
perf-profile.children.cycles-pp.__d_lookup_rcu
>>       0.10 =C2=B1 15%      -0.1        0.04 =C2=B1 73%  =
perf-profile.children.cycles-pp.generic_permission
>>       0.14 =C2=B1  9%      -0.1        0.08 =C2=B1 20%  =
perf-profile.children.cycles-pp.__x86_retpoline_rax
>>       0.08 =C2=B1  5%      -0.1        0.03 =C2=B1 70%  =
perf-profile.children.cycles-pp.ktime_get_ts64
>>       0.09 =C2=B1  4%      -0.1        0.04 =C2=B1 71%  =
perf-profile.children.cycles-pp.__might_fault
>>       0.07 =C2=B1 17%      -0.0        0.03 =C2=B1 70%  =
perf-profile.children.cycles-pp.schedule_timeout
>>       0.11 =C2=B1  9%      -0.0        0.08 =C2=B1 12%  =
perf-profile.children.cycles-pp.update_load_avg
>>       0.09 =C2=B1  8%      -0.0        0.06 =C2=B1  8%  =
perf-profile.children.cycles-pp.newidle_balance
>>       0.10 =C2=B1 14%      -0.0        0.07 =C2=B1  7%  =
perf-profile.children.cycles-pp.task_tick_fair
>>       0.06 =C2=B1 15%      +0.0        0.08 =C2=B1 16%  =
perf-profile.children.cycles-pp.tick_irq_enter
>>       0.04 =C2=B1 57%      +0.0        0.06        =
perf-profile.children.cycles-pp.sched_clock_cpu
>>       0.08 =C2=B1 13%      +0.0        0.11 =C2=B1  4%  =
perf-profile.children.cycles-pp.irq_enter_rcu
>>       0.07 =C2=B1  5%      +0.0        0.12 =C2=B1 24%  =
perf-profile.children.cycles-pp.clockevents_program_event
>>       0.01 =C2=B1173%      +0.1        0.07 =C2=B1 18%  =
perf-profile.children.cycles-pp.rebalance_domains
>>       0.09 =C2=B1  4%      +0.1        0.15 =C2=B1 26%  =
perf-profile.children.cycles-pp.ktime_get
>>       0.16 =C2=B1  9%      +0.1        0.23 =C2=B1  7%  =
perf-profile.children.cycles-pp.menu_select
>>       0.21 =C2=B1 11%      +0.1        0.28 =C2=B1 16%  =
perf-profile.children.cycles-pp.io_serial_out
>>       0.15 =C2=B1 20%      +0.1        0.23 =C2=B1  6%  =
perf-profile.children.cycles-pp.delay_tsc
>>       1.83 =C2=B1 14%      +0.5        2.38 =C2=B1 12%  =
perf-profile.children.cycles-pp.serial8250_console_putchar
>>       1.85 =C2=B1 14%      +0.6        2.40 =C2=B1 12%  =
perf-profile.children.cycles-pp.wait_for_xmitr
>>       1.99 =C2=B1 15%      +0.6        2.56 =C2=B1 16%  =
perf-profile.children.cycles-pp.__dynamic_pr_debug
>>       1.82 =C2=B1 13%      +0.6        2.39 =C2=B1 17%  =
perf-profile.children.cycles-pp.create_basic_memory_bitmaps
>>       2.13 =C2=B1 13%      +0.6        2.74 =C2=B1 13%  =
perf-profile.children.cycles-pp.console_unlock
>>       2.03 =C2=B1 13%      +0.6        2.65 =C2=B1 12%  =
perf-profile.children.cycles-pp.uart_console_write
>>       2.17 =C2=B1 15%      +0.6        2.79 =C2=B1 14%  =
perf-profile.children.cycles-pp.printk
>>       2.17 =C2=B1 15%      +0.6        2.79 =C2=B1 14%  =
perf-profile.children.cycles-pp.vprintk_emit
>>       2.05 =C2=B1 13%      +0.6        2.67 =C2=B1 12%  =
perf-profile.children.cycles-pp.serial8250_console_write
>>       0.00            +3.7        3.73 =C2=B1 66%  =
perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
>>       2.92 =C2=B1  6%      -1.5        1.44 =C2=B1 22%  =
perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>>       1.48 =C2=B1  5%      -0.7        0.74 =C2=B1 28%  =
perf-profile.self.cycles-pp.syscall_return_via_sysret
>>       1.25 =C2=B1  6%      -0.6        0.62 =C2=B1 28%  =
perf-profile.self.cycles-pp.__entry_text_start
>>       0.52 =C2=B1 18%      -0.4        0.13 =C2=B1 34%  =
perf-profile.self.cycles-pp.apparmor_file_open
>>       0.50 =C2=B1 32%      -0.4        0.13 =C2=B1 54%  =
perf-profile.self.cycles-pp.rwsem_spin_on_owner
>>       0.44 =C2=B1  5%      -0.3        0.13 =C2=B1 36%  =
perf-profile.self.cycles-pp.lockref_put_or_lock
>>       0.38 =C2=B1 12%      -0.3        0.12 =C2=B1 18%  =
perf-profile.self.cycles-pp.apparmor_file_alloc_security
>>       0.52 =C2=B1  4%      -0.3        0.27 =C2=B1 25%  =
perf-profile.self.cycles-pp._raw_spin_lock
>>       0.28 =C2=B1 22%      -0.2        0.05 =C2=B1 72%  =
perf-profile.self.cycles-pp.aa_get_task_label
>>       0.45 =C2=B1  7%      -0.2        0.24 =C2=B1 20%  =
perf-profile.self.cycles-pp.kmem_cache_alloc
>>       0.39 =C2=B1 10%      -0.2        0.19 =C2=B1 36%  =
perf-profile.self.cycles-pp.__fget_files
>>       0.28 =C2=B1 19%      -0.2        0.08 =C2=B1 11%  =
perf-profile.self.cycles-pp.apparmor_file_free_security
>>       0.30 =C2=B1  8%      -0.2        0.11 =C2=B1 36%  =
perf-profile.self.cycles-pp.do_dentry_open
>>       0.21 =C2=B1 21%      -0.2        0.04 =C2=B1 76%  =
perf-profile.self.cycles-pp.mutex_lock
>>       0.20 =C2=B1  3%      -0.1        0.06 =C2=B1 71%  =
perf-profile.self.cycles-pp.lockref_get_not_dead
>>       0.20 =C2=B1 11%      -0.1        0.06 =C2=B1 73%  =
perf-profile.self.cycles-pp.vm_unmapped_area
>>       0.18 =C2=B1  8%      -0.1        0.06 =C2=B1 73%  =
perf-profile.self.cycles-pp.common_file_perm
>>       0.17 =C2=B1 14%      -0.1        0.04 =C2=B1 76%  =
perf-profile.self.cycles-pp.kobject_put
>>       0.27 =C2=B1 15%      -0.1        0.15 =C2=B1 25%  =
perf-profile.self.cycles-pp.__alloc_file
>>       0.16 =C2=B1 39%      -0.1        0.05 =C2=B1 78%  =
perf-profile.self.cycles-pp.rwsem_down_write_slowpath
>>       0.16 =C2=B1 11%      -0.1        0.05 =C2=B1 77%  =
perf-profile.self.cycles-pp.fput_many
>>       0.14 =C2=B1  7%      -0.1        0.04 =C2=B1 71%  =
perf-profile.self.cycles-pp.__might_sleep
>>       0.18 =C2=B1  5%      -0.1        0.09 =C2=B1 30%  =
perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>>       0.14 =C2=B1 11%      -0.1        0.04 =C2=B1 71%  =
perf-profile.self.cycles-pp.do_sys_openat2
>>       0.15 =C2=B1  5%      -0.1        0.06 =C2=B1 73%  =
perf-profile.self.cycles-pp.__fput
>>       0.20 =C2=B1  5%      -0.1        0.11 =C2=B1 31%  =
perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>>       0.13 =C2=B1 14%      -0.1        0.04 =C2=B1 70%  =
perf-profile.self.cycles-pp.link_path_walk
>>       0.18 =C2=B1  8%      -0.1        0.09 =C2=B1 18%  =
perf-profile.self.cycles-pp.___might_sleep
>>       0.13 =C2=B1 14%      -0.1        0.04 =C2=B1 71%  =
perf-profile.self.cycles-pp.get_obj_cgroup_from_current
>>       0.12 =C2=B1  6%      -0.1        0.04 =C2=B1 73%  =
perf-profile.self.cycles-pp.do_mmap
>>       0.12 =C2=B1 10%      -0.1        0.05 =C2=B1 71%  =
perf-profile.self.cycles-pp.__x86_retpoline_rax
>>       0.12 =C2=B1 24%      -0.1        0.05 =C2=B1 72%  =
perf-profile.self.cycles-pp.allocate_slab
>>       0.12 =C2=B1  8%      -0.1        0.06 =C2=B1 19%  =
perf-profile.self.cycles-pp.__d_lookup_rcu
>>       0.10 =C2=B1 13%      -0.1        0.04 =C2=B1 71%  =
perf-profile.self.cycles-pp.generic_permission
>>       0.09 =C2=B1  8%      -0.1        0.04 =C2=B1 71%  =
perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>>       0.10 =C2=B1  4%      -0.0        0.05 =C2=B1  8%  =
perf-profile.self.cycles-pp.syscall_enter_from_user_mode
>>       0.07 =C2=B1 17%      +0.0        0.11 =C2=B1  8%  =
perf-profile.self.cycles-pp.cpuidle_enter_state
>>       0.10 =C2=B1  9%      +0.0        0.14 =C2=B1 10%  =
perf-profile.self.cycles-pp.menu_select
>>       0.03 =C2=B1100%      +0.1        0.09 =C2=B1 36%  =
perf-profile.self.cycles-pp.ktime_get
>>       0.15 =C2=B1 20%      +0.1        0.23 =C2=B1  6%  =
perf-profile.self.cycles-pp.delay_tsc
>>       0.20 =C2=B1 16%      +0.1        0.28 =C2=B1 16%  =
perf-profile.self.cycles-pp.io_serial_out
>>       0.00            +3.7        3.73 =C2=B1 66%  =
perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
>>=20
>>=20
>>                                                                       =
                                        stress-ng.zero.ops_per_sec
>>                                                                       =
             400000 =
+------------------------------------------------------------------+
>>          |.+.. .+..                     .+..+.  .+.+..       +..      =
      |
>>   350000 |-+  +    +    +.+..+.+.. .+..+    O +. O O  +.+..O+O  =
+.+..+.+..+.|
>>          | O       : O  : O    O  +    O O                 +      O  =
O O    |
>>   300000 |-+       :    :    O                                        =
      |
>>   250000 |-+        :  :                                              =
      |
>>          |          :  :                                              =
      |
>>   200000 |-+        :  :                                              =
      |
>>          |          :  :                                              =
      |
>>   150000 |-+        : :                                               =
      |
>>   100000 |-+        : :                                               =
      |
>>          |           ::                                               =
      |
>>    50000 |-+         ::                                               =
      |
>>          |           :                                                =
      |
>>        0 =
+------------------------------------------------------------------+
>>                                                                       =
                                                                         =
                  [*] bisect-good sample
>> [O] bisect-bad  sample
>>=20
>> =
**************************************************************************=
*************************
>> lkp-csl-2ap2: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ =
2.30GHz with 192G memory
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/r=
ootfs/sync_method/tbox_group/test_size/testcase/ucode:
>>   =
gcc-9/performance/1BRD_48G/4M/btrfs/1x/x86_64-rhel-8.3/64t/debian-10.4-x86=
_64-20200603.cgz/NoSync/lkp-csl-2ap2/24G/fsmark/0x5003003
>>=20
>> commit:
>>   cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")
>>   0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of =
qspinlock")
>>=20
>> cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5
>> ---------------- ---------------------------
>>          %stddev     %change         %stddev
>>              \          |                \
>>       1180 =C2=B1  2%    +213.9%       3706 =C2=B1 11%  =
fsmark.files_per_sec
>>     773.00 =C2=B1  4%     -30.2%     539.75 =C2=B1  7%  =
fsmark.time.percent_of_cpu_this_job_got
>>     137.19 =C2=B1  3%     -28.5%      98.13 =C2=B1  8%  =
fsmark.time.system_time
>>      48917 =C2=B1  4%      -9.0%      44537 =C2=B1  8%  =
meminfo.AnonHugePages
>>       4.83 =C2=B1  4%      -1.0        3.83 =C2=B1  5%  =
mpstat.cpu.all.sys%
>>      93.48            +1.1%      94.51        iostat.cpu.idle
>>       5.76 =C2=B1  2%     -16.9%       4.79 =C2=B1  6%  =
iostat.cpu.system
>>      93.00            +1.1%      94.00        vmstat.cpu.id
>>      20606 =C2=B1  5%     +97.4%      40682 =C2=B1 34%  =
vmstat.system.cs
>>    4237881 =C2=B1 29%    +321.3%   17854499 =C2=B1106%  =
cpuidle.C1.time
>>      44169 =C2=B1 32%    +396.5%     219318 =C2=B1113%  =
cpuidle.C1.usage
>>      72208 =C2=B1  6%    +191.8%     210719 =C2=B1 39%  =
cpuidle.POLL.time
>>      36708 =C2=B1  9%    +306.0%     149034 =C2=B1 48%  =
cpuidle.POLL.usage
>>       2157 =C2=B1  2%     +13.8%       2454 =C2=B1  6%  =
slabinfo.biovec-max.active_objs
>>       2271 =C2=B1  2%     +12.8%       2561 =C2=B1  5%  =
slabinfo.biovec-max.num_objs
>>       6624           +13.4%       7512 =C2=B1  5%  =
slabinfo.btrfs_delayed_node.active_objs
>>       6768           +12.1%       7589 =C2=B1  5%  =
slabinfo.btrfs_delayed_node.num_objs
>>      47815 =C2=B1 86%     -89.2%       5149 =C2=B1  6%  =
sched_debug.cfs_rq:/.load.stddev
>>     142.69 =C2=B1 15%     +66.8%     237.99 =C2=B1 13%  =
sched_debug.cfs_rq:/.load_avg.avg
>>       1598 =C2=B1 30%     +92.4%       3075 =C2=B1 20%  =
sched_debug.cfs_rq:/.load_avg.max
>>     383.38 =C2=B1 21%     +90.4%     730.10 =C2=B1 13%  =
sched_debug.cfs_rq:/.load_avg.stddev
>>      37712 =C2=B1 16%     -27.1%      27508 =C2=B1 16%  =
sched_debug.cfs_rq:/.min_vruntime.avg
>>      58.89 =C2=B1 49%     +57.8%      92.96 =C2=B1  5%  =
sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>       1901 =C2=B1  4%      -8.3%       1743 =C2=B1  3%  =
proc-vmstat.nr_active_anon
>>    5055884            +3.2%    5219972        =
proc-vmstat.nr_file_pages
>>    4788961 =C2=B1  2%      +3.4%    4953360        =
proc-vmstat.nr_inactive_file
>>      36576 =C2=B1  2%      -4.1%      35069        =
proc-vmstat.nr_kernel_stack
>>       9756            -1.6%       9601        proc-vmstat.nr_mapped
>>       5205 =C2=B1  2%      -5.1%       4939        =
proc-vmstat.nr_shmem
>>       1901 =C2=B1  4%      -8.3%       1743 =C2=B1  3%  =
proc-vmstat.nr_zone_active_anon
>>    4788961 =C2=B1  2%      +3.4%    4953360        =
proc-vmstat.nr_zone_inactive_file
>>       4864 =C2=B1  5%      -8.2%       4465        =
proc-vmstat.pgactivate
>>  2.507e+09            -8.7%   2.29e+09        =
perf-stat.i.branch-instructions
>>   71942409            -5.3%   68125925 =C2=B1  2%  =
perf-stat.i.cache-misses
>>  4.372e+10           -18.5%  3.565e+10 =C2=B1  3%  =
perf-stat.i.cpu-cycles
>>  1.231e+10            -7.5%  1.138e+10        =
perf-stat.i.instructions
>>       2515 =C2=B1  8%     -11.4%       2228 =C2=B1  5%  =
perf-stat.i.instructions-per-iTLB-miss
>>       0.23           -17.3%       0.19 =C2=B1  3%  =
perf-stat.i.metric.GHz
>>       0.71 =C2=B1 19%     +37.6%       0.97 =C2=B1 17%  =
perf-stat.i.metric.K/sec
>>      35.43            -6.2%      33.24 =C2=B1  2%  =
perf-stat.i.metric.M/sec
>>       3.58            -8.5%       3.28        perf-stat.overall.cpi
>>     612.62            -9.0%     557.36 =C2=B1  3%  =
perf-stat.overall.cycles-between-cache-misses
>>       2610 =C2=B1  6%     -11.9%       2299 =C2=B1  4%  =
perf-stat.overall.instructions-per-iTLB-miss
>>       0.28            +9.3%       0.31        perf-stat.overall.ipc
>>   2.39e+09 =C2=B1  2%      -6.3%  2.239e+09        =
perf-stat.ps.branch-instructions
>>   68534728 =C2=B1  2%      -4.6%   65359103 =C2=B1  2%  =
perf-stat.ps.cache-misses
>>  4.199e+10 =C2=B1  2%     -13.3%  3.641e+10        =
perf-stat.ps.cpu-cycles
>>  1.173e+10 =C2=B1  2%      -5.3%  1.112e+10        =
perf-stat.ps.instructions
>>     226946 =C2=B1 18%     +44.8%     328685 =C2=B1 19%  =
numa-meminfo.node0.AnonPages
>>     249710 =C2=B1 18%     +41.9%     354296 =C2=B1 20%  =
numa-meminfo.node0.AnonPages.max
>>     233745 =C2=B1 17%     +42.0%     331984 =C2=B1 20%  =
numa-meminfo.node0.Inactive(anon)
>>       8680 =C2=B1 73%    +135.9%      20474 =C2=B1 28%  =
numa-meminfo.node0.PageTables
>>     250653 =C2=B1  2%      +6.8%     267784 =C2=B1  5%  =
numa-meminfo.node0.Unevictable
>>    2890241 =C2=B1  9%     -58.3%    1206212 =C2=B1 10%  =
numa-meminfo.node0.Writeback
>>     338312 =C2=B1 83%    +111.9%     716979 =C2=B1 64%  =
numa-meminfo.node1.Dirty
>>       8444 =C2=B1 82%    +169.8%      22785 =C2=B1 37%  =
numa-meminfo.node2.AnonHugePages
>>     236489 =C2=B1 16%    +142.5%     573382 =C2=B1 36%  =
numa-meminfo.node2.Dirty
>>    2484617 =C2=B1 13%    +117.6%    5406277 =C2=B1 50%  =
numa-meminfo.node2.FilePages
>>    2459002 =C2=B1 19%    +115.1%    5290461 =C2=B1 51%  =
numa-meminfo.node2.Inactive
>>    2216704 =C2=B1 16%    +131.7%    5135596 =C2=B1 53%  =
numa-meminfo.node2.Inactive(file)
>>     871702 =C2=B1 16%     +52.8%    1331684 =C2=B1  6%  =
numa-meminfo.node2.Writeback
>>       3888 =C2=B1 16%     -24.5%       2937 =C2=B1  6%  =
numa-meminfo.node3.Active(anon)
>>      57796 =C2=B1 19%     -49.7%      29078 =C2=B1 34%  =
numa-meminfo.node3.KReclaimable
>>      57796 =C2=B1 19%     -49.7%      29078 =C2=B1 34%  =
numa-meminfo.node3.SReclaimable
>>     130240 =C2=B1  7%     -30.1%      91037 =C2=B1 15%  =
numa-meminfo.node3.Slab
>>      56616 =C2=B1 18%     +45.2%      82199 =C2=B1 19%  =
numa-vmstat.node0.nr_anon_pages
>>      58314 =C2=B1 17%     +42.4%      83024 =C2=B1 20%  =
numa-vmstat.node0.nr_inactive_anon
>>       2172 =C2=B1 73%    +135.7%       5122 =C2=B1 28%  =
numa-vmstat.node0.nr_page_table_pages
>>      62662 =C2=B1  2%      +6.8%      66945 =C2=B1  5%  =
numa-vmstat.node0.nr_unevictable
>>     738434 =C2=B1  9%     -59.3%     300391 =C2=B1 10%  =
numa-vmstat.node0.nr_writeback
>>      58312 =C2=B1 17%     +42.4%      83023 =C2=B1 20%  =
numa-vmstat.node0.nr_zone_inactive_anon
>>      62662 =C2=B1  2%      +6.8%      66945 =C2=B1  5%  =
numa-vmstat.node0.nr_zone_unevictable
>>     926442 =C2=B1  6%     -53.1%     434282 =C2=B1 12%  =
numa-vmstat.node0.nr_zone_write_pending
>>      84324 =C2=B1 81%    +112.0%     178764 =C2=B1 64%  =
numa-vmstat.node1.nr_dirty
>>     427046 =C2=B1 84%     +74.8%     746464 =C2=B1 46%  =
numa-vmstat.node1.nr_zone_write_pending
>>     627042 =C2=B1 18%    +129.0%    1435752 =C2=B1 55%  =
numa-vmstat.node2.nr_dirtied
>>      59963 =C2=B1 18%    +137.8%     142585 =C2=B1 36%  =
numa-vmstat.node2.nr_dirty
>>     634106 =C2=B1 15%    +112.1%    1345185 =C2=B1 50%  =
numa-vmstat.node2.nr_file_pages
>>     567086 =C2=B1 17%    +125.3%    1277507 =C2=B1 53%  =
numa-vmstat.node2.nr_inactive_file
>>     223407 =C2=B1 17%     +48.3%     331299 =C2=B1  7%  =
numa-vmstat.node2.nr_writeback
>>     567087 =C2=B1 17%    +125.3%    1277515 =C2=B1 53%  =
numa-vmstat.node2.nr_zone_inactive_file
>>     283372 =C2=B1 17%     +67.2%     473906 =C2=B1  8%  =
numa-vmstat.node2.nr_zone_write_pending
>>     922.00 =C2=B1 19%     -20.0%     737.25 =C2=B1  6%  =
numa-vmstat.node3.nr_active_anon
>>      14591 =C2=B1 20%     -50.1%       7276 =C2=B1 35%  =
numa-vmstat.node3.nr_slab_reclaimable
>>     922.00 =C2=B1 19%     -20.0%     737.25 =C2=B1  6%  =
numa-vmstat.node3.nr_zone_active_anon
>>     141466 =C2=B1 17%    +523.4%     881964 =C2=B1 85%  =
numa-vmstat.node3.numa_other
>>     282981 =C2=B1 14%     +46.6%     414731 =C2=B1 12%  =
interrupts.CAL:Function_call_interrupts
>>     770.00 =C2=B1 51%     -56.5%     335.00 =C2=B1 59%  =
interrupts.CPU0.NMI:Non-maskable_interrupts
>>     770.00 =C2=B1 51%     -56.5%     335.00 =C2=B1 59%  =
interrupts.CPU0.PMI:Performance_monitoring_interrupts
>>     346.25 =C2=B1 15%     -46.7%     184.50 =C2=B1 23%  =
interrupts.CPU110.NMI:Non-maskable_interrupts
>>     346.25 =C2=B1 15%     -46.7%     184.50 =C2=B1 23%  =
interrupts.CPU110.PMI:Performance_monitoring_interrupts
>>       1359 =C2=B1 14%     +31.7%       1789 =C2=B1 17%  =
interrupts.CPU128.CAL:Function_call_interrupts
>>       1378 =C2=B1 14%   +2294.9%      33020 =C2=B1164%  =
interrupts.CPU153.CAL:Function_call_interrupts
>>     214.50 =C2=B1 34%     +91.7%     411.25 =C2=B1 39%  =
interrupts.CPU16.NMI:Non-maskable_interrupts
>>     214.50 =C2=B1 34%     +91.7%     411.25 =C2=B1 39%  =
interrupts.CPU16.PMI:Performance_monitoring_interrupts
>>     403.50 =C2=B1 35%     -40.3%     241.00 =C2=B1  8%  =
interrupts.CPU169.NMI:Non-maskable_interrupts
>>     403.50 =C2=B1 35%     -40.3%     241.00 =C2=B1  8%  =
interrupts.CPU169.PMI:Performance_monitoring_interrupts
>>     439.00 =C2=B1 50%     -51.5%     212.75 =C2=B1 22%  =
interrupts.CPU170.NMI:Non-maskable_interrupts
>>     439.00 =C2=B1 50%     -51.5%     212.75 =C2=B1 22%  =
interrupts.CPU170.PMI:Performance_monitoring_interrupts
>>       1062 =C2=B1116%     -77.3%     240.75 =C2=B1 23%  =
interrupts.CPU174.NMI:Non-maskable_interrupts
>>       1062 =C2=B1116%     -77.3%     240.75 =C2=B1 23%  =
interrupts.CPU174.PMI:Performance_monitoring_interrupts
>>     291.25 =C2=B1 31%     -34.2%     191.75 =C2=B1 30%  =
interrupts.CPU2.NMI:Non-maskable_interrupts
>>     291.25 =C2=B1 31%     -34.2%     191.75 =C2=B1 30%  =
interrupts.CPU2.PMI:Performance_monitoring_interrupts
>>     342.00 =C2=B1 43%     -58.3%     142.75 =C2=B1 16%  =
interrupts.CPU22.NMI:Non-maskable_interrupts
>>     342.00 =C2=B1 43%     -58.3%     142.75 =C2=B1 16%  =
interrupts.CPU22.PMI:Performance_monitoring_interrupts
>>     241.25 =C2=B1 22%     -42.6%     138.50 =C2=B1 22%  =
interrupts.CPU23.NMI:Non-maskable_interrupts
>>     241.25 =C2=B1 22%     -42.6%     138.50 =C2=B1 22%  =
interrupts.CPU23.PMI:Performance_monitoring_interrupts
>>       1365 =C2=B1 14%     +49.5%       2041 =C2=B1 24%  =
interrupts.CPU35.CAL:Function_call_interrupts
>>     222.00 =C2=B1 94%    +175.1%     610.75 =C2=B1 51%  =
interrupts.CPU63.NMI:Non-maskable_interrupts
>>     222.00 =C2=B1 94%    +175.1%     610.75 =C2=B1 51%  =
interrupts.CPU63.PMI:Performance_monitoring_interrupts
>>     146.75 =C2=B1 39%    +104.6%     300.25 =C2=B1 32%  =
interrupts.CPU64.NMI:Non-maskable_interrupts
>>     146.75 =C2=B1 39%    +104.6%     300.25 =C2=B1 32%  =
interrupts.CPU64.PMI:Performance_monitoring_interrupts
>>     557.00 =C2=B1 88%     -61.3%     215.75 =C2=B1 21%  =
interrupts.CPU74.NMI:Non-maskable_interrupts
>>     557.00 =C2=B1 88%     -61.3%     215.75 =C2=B1 21%  =
interrupts.CPU74.PMI:Performance_monitoring_interrupts
>>     319.25 =C2=B1 22%     -43.9%     179.25 =C2=B1 36%  =
interrupts.CPU75.NMI:Non-maskable_interrupts
>>     319.25 =C2=B1 22%     -43.9%     179.25 =C2=B1 36%  =
interrupts.CPU75.PMI:Performance_monitoring_interrupts
>>       1343 =C2=B1 15%     +23.0%       1652 =C2=B1  4%  =
interrupts.CPU80.CAL:Function_call_interrupts
>>       1095 =C2=B1 66%     -76.5%     257.00 =C2=B1 17%  =
interrupts.CPU96.NMI:Non-maskable_interrupts
>>       1095 =C2=B1 66%     -76.5%     257.00 =C2=B1 17%  =
interrupts.CPU96.PMI:Performance_monitoring_interrupts
>>     817.25 =C2=B1 12%     +62.6%       1329 =C2=B1 17%  =
interrupts.RES:Rescheduling_interrupts
>>      12.39 =C2=B1 23%      -8.2        4.22 =C2=B1  6%  =
perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>>      12.35 =C2=B1 24%      -8.1        4.21 =C2=B1  6%  =
perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame
>>      12.12 =C2=B1 24%      -8.0        4.08 =C2=B1  6%  =
perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64=
_after_hwframe
>>      12.11 =C2=B1 24%      -8.0        4.07 =C2=B1  6%  =
perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
>>      12.10 =C2=B1 24%      -8.0        4.06 =C2=B1  6%  =
perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_=
write.ksys_write.do_syscall_64
>>      12.07 =C2=B1 24%      -8.0        4.04 =C2=B1  6%  =
perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_ite=
r.new_sync_write.vfs_write.ksys_write
>>      12.28 =C2=B1 24%      -7.5        4.83 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe
>>       6.07 =C2=B1 31%      -6.1        0.00        =
perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spi=
n_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve=
_metadata
>>       6.36 =C2=B1 30%      -4.8        1.55 =C2=B1 11%  =
perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buf=
fered_write.btrfs_file_write_iter.new_sync_write.vfs_write
>>       6.31 =C2=B1 30%      -4.8        1.51 =C2=B1 12%  =
perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_by=
tes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_=
iter
>>       6.31 =C2=B1 30%      -4.8        1.51 =C2=B1 12%  =
perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delall=
oc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_wr=
ite
>>       6.13 =C2=B1 31%      -4.8        1.38 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_rese=
rve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
>>       4.39 =C2=B1 18%      -3.2        1.21 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_wr=
ite.btrfs_file_write_iter.new_sync_write.vfs_write
>>       4.38 =C2=B1 18%      -3.2        1.20 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_r=
elease.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
>>       4.21 =C2=B1 19%      -3.1        1.09 =C2=B1 20%  =
perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.bt=
rfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter
>>       0.13 =C2=B1173%      +0.5        0.63 =C2=B1  6%  =
perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_inte=
rrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>>       4.51 =C2=B1  6%      +0.5        5.04 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_time=
r_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_en=
ter
>>       4.48 =C2=B1  5%      +0.5        5.02 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sy=
svec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.=
cpuidle_enter_state
>>       4.37 =C2=B1  6%      +0.6        4.93 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_int=
errupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_api=
c_timer_interrupt
>>       0.18 =C2=B1173%      +0.6        0.75 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.=
devkmsg_write.cold.new_sync_write
>>       0.18 =C2=B1173%      +0.6        0.76 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.c=
old.new_sync_write.vfs_write
>>       0.18 =C2=B1173%      +0.6        0.76 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_write.vfs_wri=
te.ksys_write.do_syscall_64
>>       0.18 =C2=B1173%      +0.6        0.76 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.new_sync_=
write.vfs_write.ksys_write
>>       0.18 =C2=B1173%      +0.6        0.77 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>>       0.18 =C2=B1173%      +0.6        0.77 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.write
>>       0.18 =C2=B1173%      +0.6        0.77 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64=
_after_hwframe.write
>>       0.18 =C2=B1173%      +0.6        0.77 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.write
>>       0.18 =C2=B1173%      +0.6        0.77 =C2=B1 27%  =
perf-profile.calltrace.cycles-pp.write
>>       0.00            +0.6        0.62 =C2=B1  7%  =
perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_=
timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>>       0.00            +1.1        1.06 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin=
_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write=

>>       7.48 =C2=B1  5%      +1.2        8.68 =C2=B1  2%  =
perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_ap=
ic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
>>       0.00            +1.3        1.33 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin=
_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_=
metadata
>>      11.79 =C2=B1  8%      +2.8       14.63 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_e=
nter_state.cpuidle_enter.do_idle.cpu_startup_entry
>>       9.11 =C2=B1 14%      +4.4       13.51 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.sta=
rt_secondary.secondary_startup_64_no_verify
>>      10.58 =C2=B1 26%     -10.6        0.00        =
perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>      12.10 =C2=B1 24%      -8.0        4.06 =C2=B1  6%  =
perf-profile.children.cycles-pp.btrfs_file_write_iter
>>      12.07 =C2=B1 24%      -8.0        4.04 =C2=B1  6%  =
perf-profile.children.cycles-pp.btrfs_buffered_write
>>      14.00 =C2=B1 18%      -7.9        6.09 =C2=B1  7%  =
perf-profile.children.cycles-pp._raw_spin_lock
>>      12.64 =C2=B1 23%      -7.8        4.85 =C2=B1  5%  =
perf-profile.children.cycles-pp.ksys_write
>>      12.62 =C2=B1 24%      -7.8        4.83 =C2=B1  5%  =
perf-profile.children.cycles-pp.new_sync_write
>>      12.63 =C2=B1 23%      -7.8        4.85 =C2=B1  5%  =
perf-profile.children.cycles-pp.vfs_write
>>      13.17 =C2=B1 23%      -7.6        5.60 =C2=B1  6%  =
perf-profile.children.cycles-pp.do_syscall_64
>>      13.24 =C2=B1 23%      -7.3        5.92 =C2=B1  6%  =
perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>>       6.38 =C2=B1 30%      -4.8        1.55 =C2=B1 12%  =
perf-profile.children.cycles-pp.__reserve_bytes
>>       6.33 =C2=B1 30%      -4.8        1.52 =C2=B1 12%  =
perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
>>       6.36 =C2=B1 30%      -4.8        1.55 =C2=B1 11%  =
perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
>>       4.49 =C2=B1 18%      -3.3        1.23 =C2=B1 15%  =
perf-profile.children.cycles-pp.btrfs_block_rsv_release
>>       4.39 =C2=B1 18%      -3.2        1.21 =C2=B1 15%  =
perf-profile.children.cycles-pp.btrfs_inode_rsv_release
>>       0.16 =C2=B1 77%      -0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp.do_filp_open
>>       0.16 =C2=B1 77%      -0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp.path_openat
>>       0.16 =C2=B1 75%      -0.1        0.06 =C2=B1  6%  =
perf-profile.children.cycles-pp.do_sys_open
>>       0.16 =C2=B1 75%      -0.1        0.06 =C2=B1  6%  =
perf-profile.children.cycles-pp.do_sys_openat2
>>       0.21 =C2=B1 32%      -0.1        0.13 =C2=B1 29%  =
perf-profile.children.cycles-pp.rcu_sched_clock_irq
>>       0.22 =C2=B1  9%      -0.1        0.16 =C2=B1  6%  =
perf-profile.children.cycles-pp.update_blocked_averages
>>       0.10 =C2=B1 29%      -0.0        0.05 =C2=B1 70%  =
perf-profile.children.cycles-pp.update_ts_time_stats
>>       0.07 =C2=B1 12%      -0.0        0.04 =C2=B1 58%  =
perf-profile.children.cycles-pp.__pagevec_lru_add_fn
>>       0.16 =C2=B1  9%      +0.0        0.20 =C2=B1 12%  =
perf-profile.children.cycles-pp.brd_lookup_page
>>       0.13 =C2=B1 11%      +0.0        0.17 =C2=B1 18%  =
perf-profile.children.cycles-pp.__radix_tree_lookup
>>       0.14 =C2=B1  7%      +0.1        0.20 =C2=B1  9%  =
perf-profile.children.cycles-pp.__intel_pmu_enable_all
>>       0.48 =C2=B1  8%      +0.1        0.62 =C2=B1  8%  =
perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>>       0.51 =C2=B1 29%      +0.3        0.77 =C2=B1 27%  =
perf-profile.children.cycles-pp.write
>>       0.39 =C2=B1 32%      +0.3        0.65 =C2=B1  6%  =
perf-profile.children.cycles-pp.tick_nohz_irq_exit
>>       0.50 =C2=B1 30%      +0.3        0.76 =C2=B1 27%  =
perf-profile.children.cycles-pp.devkmsg_write.cold
>>       0.50 =C2=B1 30%      +0.3        0.76 =C2=B1 27%  =
perf-profile.children.cycles-pp.devkmsg_emit
>>       0.03 =C2=B1173%      +0.3        0.29 =C2=B1108%  =
perf-profile.children.cycles-pp.osq_lock
>>       0.03 =C2=B1173%      +0.3        0.29 =C2=B1107%  =
perf-profile.children.cycles-pp.__mutex_lock
>>       0.11 =C2=B1130%      +0.3        0.45 =C2=B1 68%  =
perf-profile.children.cycles-pp.__do_sys_finit_module
>>       0.11 =C2=B1130%      +0.3        0.45 =C2=B1 68%  =
perf-profile.children.cycles-pp.load_module
>>       0.11 =C2=B1130%      +0.3        0.45 =C2=B1 67%  =
perf-profile.children.cycles-pp.syscall
>>       0.14 =C2=B1 88%      +0.4        0.54 =C2=B1 53%  =
perf-profile.children.cycles-pp.wb_workfn
>>       0.14 =C2=B1 88%      +0.4        0.54 =C2=B1 53%  =
perf-profile.children.cycles-pp.wb_writeback
>>       0.14 =C2=B1 88%      +0.4        0.54 =C2=B1 53%  =
perf-profile.children.cycles-pp.writeback_sb_inodes
>>       0.12 =C2=B1105%      +0.4        0.53 =C2=B1 54%  =
perf-profile.children.cycles-pp.__writeback_single_inode
>>       4.76 =C2=B1  5%      +0.5        5.21 =C2=B1  3%  =
perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>>       4.65 =C2=B1  5%      +0.5        5.13 =C2=B1  2%  =
perf-profile.children.cycles-pp.hrtimer_interrupt
>>       6.15 =C2=B1  5%      +0.5        6.65 =C2=B1  2%  =
perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
>>       2.06 =C2=B1 28%      +1.0        3.05 =C2=B1  9%  =
perf-profile.children.cycles-pp.ktime_get
>>       7.80 =C2=B1  4%      +1.1        8.94 =C2=B1  2%  =
perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>>      10.10 =C2=B1  6%      +2.0       12.05 =C2=B1  6%  =
perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>>       0.00            +2.6        2.56 =C2=B1 19%  =
perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
>>       9.16 =C2=B1 14%      +4.4       13.57 =C2=B1 18%  =
perf-profile.children.cycles-pp.menu_select
>>      10.50 =C2=B1 26%     -10.5        0.00        =
perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>       0.18 =C2=B1 30%      -0.1        0.11 =C2=B1 27%  =
perf-profile.self.cycles-pp.rcu_sched_clock_irq
>>       0.10 =C2=B1 11%      +0.0        0.13 =C2=B1 10%  =
perf-profile.self.cycles-pp.__extent_writepage
>>       0.14 =C2=B1  7%      +0.1        0.20 =C2=B1  9%  =
perf-profile.self.cycles-pp.__intel_pmu_enable_all
>>       0.08 =C2=B1 10%      +0.1        0.16 =C2=B1 22%  =
perf-profile.self.cycles-pp.end_page_writeback
>>       0.03 =C2=B1173%      +0.2        0.28 =C2=B1105%  =
perf-profile.self.cycles-pp.osq_lock
>>       1.77 =C2=B1 32%      +1.0        2.75 =C2=B1 10%  =
perf-profile.self.cycles-pp.ktime_get
>>       0.00            +2.5        2.51 =C2=B1 19%  =
perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
>>       7.68 =C2=B1 15%      +4.1       11.79 =C2=B1 21%  =
perf-profile.self.cycles-pp.menu_select
>>=20
>>=20
>>=20
>> =
**************************************************************************=
*************************
>> lkp-csl-2ap3: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ =
2.30GHz with 192G memory
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/t=
estcase/ucode:
>>   =
gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/300=
s/lkp-csl-2ap3/new_fserver/reaim/0x5003003
>>=20
>> commit:
>>   cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")
>>   0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of =
qspinlock")
>>=20
>> cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5
>> ---------------- ---------------------------
>>        fail:runs  %reproduction    fail:runs
>>            |             |             |
>>           1:4          -25%            :4     =
last_state.is_incomplete_run
>>           1:4          -25%            :4     last_state.wget_initrd
>>            :4            8%           0:4     =
perf-profile.children.cycles-pp.error_entry
>>          %stddev     %change         %stddev
>>              \          |                \
>>     556.93           -64.1%     200.03        reaim.child_systime
>>      49.95            +3.6%      51.77        reaim.child_utime
>>     318145           +96.1%     623983        reaim.jobs_per_min
>>       1657           +96.1%       3249        =
reaim.jobs_per_min_child
>>      92.26            -7.8%      85.11        reaim.jti
>>     327019          +100.4%     655467        reaim.max_jobs_per_min
>>       3.55           -49.0%       1.81        reaim.parent_time
>>       7.19 =C2=B1  2%    +100.0%      14.38 =C2=B1  4%  =
reaim.std_dev_percent
>>       0.24 =C2=B1  2%      -7.3%       0.22 =C2=B1  2%  =
reaim.std_dev_time
>>     462973           +17.9%     545826        =
reaim.time.involuntary_context_switches
>>      38288           +98.5%      75996 =C2=B1  2%  =
reaim.time.major_page_faults
>>  1.041e+08           +44.8%  1.509e+08        =
reaim.time.minor_page_faults
>>      10863           -39.7%       6549        =
reaim.time.percent_of_cpu_this_job_got
>>      30257           -47.9%      15754        reaim.time.system_time
>>       2714           +50.2%       4077        reaim.time.user_time
>>    3000456 =C2=B1  2%     +38.9%    4167220 =C2=B1  2%  =
reaim.time.voluntary_context_switches
>>    1043200           +44.9%    1512000        reaim.workload
>>      29843           +40.0%      41767        uptime.idle
>>   20127118 =C2=B1 12%     +48.7%   29930674 =C2=B1  4%  =
cpuidle.C1.time
>>     284217 =C2=B1  9%     +66.1%     472177 =C2=B1  2%  =
cpuidle.C1.usage
>>     308815 =C2=B1 13%     +26.0%     389201 =C2=B1 16%  =
cpuidle.POLL.usage
>>      41.44           +20.8       62.28        mpstat.cpu.all.idle%
>>       0.69            +1.3        1.98 =C2=B1  2%  =
mpstat.cpu.all.soft%
>>      51.88           -24.6       27.26        mpstat.cpu.all.sys%
>>       4.60            +2.3        6.91        mpstat.cpu.all.usr%
>>      41.33           +50.0%      62.00        vmstat.cpu.id
>>      53.00           -43.4%      30.00        vmstat.cpu.sy
>>     110.00           -25.9%      81.50 =C2=B1  2%  vmstat.procs.r
>>      25559 =C2=B1  2%     +46.2%      37370        vmstat.system.cs
>>     269427 =C2=B1  4%     -12.8%     234969        meminfo.Active
>>     269427 =C2=B1  4%     -12.8%     234969        =
meminfo.Active(anon)
>>      32953            +9.7%      36144 =C2=B1  2%  =
meminfo.KernelStack
>>      19202           +63.2%      31338        meminfo.PageTables
>>     483410           +11.8%     540459        meminfo.SUnreclaim
>>     304770 =C2=B1  4%     -12.8%     265628        meminfo.Shmem
>>     620741           +10.5%     685878        meminfo.Slab
>>   18788579           +43.8%   27017272 =C2=B1  4%  =
numa-numastat.node0.local_node
>>   18827783           +43.8%   27074532 =C2=B1  4%  =
numa-numastat.node0.numa_hit
>>   19046024           +45.8%   27771991 =C2=B1  2%  =
numa-numastat.node1.local_node
>>   19126483           +45.6%   27844754 =C2=B1  2%  =
numa-numastat.node1.numa_hit
>>   18849870           +44.4%   27228340 =C2=B1  2%  =
numa-numastat.node2.local_node
>>   18926181           +44.1%   27271719 =C2=B1  2%  =
numa-numastat.node2.numa_hit
>>   18622314           +46.2%   27216882 =C2=B1  3%  =
numa-numastat.node3.local_node
>>   18686267           +46.1%   27303516 =C2=B1  3%  =
numa-numastat.node3.numa_hit
>>      42977 =C2=B1 81%     -79.9%       8629 =C2=B1 59%  =
numa-meminfo.node0.Active
>>      42977 =C2=B1 81%     -79.9%       8629 =C2=B1 59%  =
numa-meminfo.node0.Active(anon)
>>       7040           +24.4%       8759 =C2=B1  8%  =
numa-meminfo.node1.KernelStack
>>       2790 =C2=B1 11%    +140.4%       6708 =C2=B1 26%  =
numa-meminfo.node1.PageTables
>>     103698           +19.3%     123717 =C2=B1  9%  =
numa-meminfo.node1.SUnreclaim
>>     129487 =C2=B1  2%     +18.0%     152790 =C2=B1  7%  =
numa-meminfo.node1.Slab
>>      32541 =C2=B1 26%     +46.6%      47695 =C2=B1 24%  =
numa-meminfo.node2.KReclaimable
>>      32541 =C2=B1 26%     +46.6%      47695 =C2=B1 24%  =
numa-meminfo.node2.SReclaimable
>>     150472 =C2=B1 20%     +21.5%     182840 =C2=B1 15%  =
numa-meminfo.node2.Slab
>>     167884 =C2=B1 33%     +71.3%     287506 =C2=B1 45%  =
numa-meminfo.node3.AnonPages.max
>>       2974 =C2=B1 11%    +145.0%       7288 =C2=B1 28%  =
numa-meminfo.node3.PageTables
>>     109568 =C2=B1  4%     +13.7%     124544 =C2=B1 12%  =
numa-meminfo.node3.SUnreclaim
>>      10666 =C2=B1 81%     -79.8%       2152 =C2=B1 59%  =
numa-vmstat.node0.nr_active_anon
>>      10665 =C2=B1 81%     -79.8%       2152 =C2=B1 59%  =
numa-vmstat.node0.nr_zone_active_anon
>>    9854862           +41.8%   13975810 =C2=B1  2%  =
numa-vmstat.node0.numa_hit
>>    9773079           +41.9%   13870000 =C2=B1  2%  =
numa-vmstat.node0.numa_local
>>       7029           +25.1%       8796 =C2=B1  8%  =
numa-vmstat.node1.nr_kernel_stack
>>     678.67 =C2=B1  8%    +152.6%       1714 =C2=B1 26%  =
numa-vmstat.node1.nr_page_table_pages
>>      25872           +20.1%      31062 =C2=B1  9%  =
numa-vmstat.node1.nr_slab_unreclaimable
>>    9970820           +42.6%   14214395        =
numa-vmstat.node1.numa_hit
>>    9810384           +43.4%   14063434        =
numa-vmstat.node1.numa_local
>>       8132 =C2=B1 26%     +46.4%      11904 =C2=B1 24%  =
numa-vmstat.node2.nr_slab_reclaimable
>>    9969168           +43.4%   14294976 =C2=B1  2%  =
numa-vmstat.node2.numa_hit
>>    9812426           +44.6%   14186949 =C2=B1  3%  =
numa-vmstat.node2.numa_local
>>     726.67 =C2=B1 12%    +158.7%       1879 =C2=B1 26%  =
numa-vmstat.node3.nr_page_table_pages
>>      27327 =C2=B1  4%     +13.9%      31114 =C2=B1 12%  =
numa-vmstat.node3.nr_slab_unreclaimable
>>    9719726           +44.0%   13991557 =C2=B1  2%  =
numa-vmstat.node3.numa_hit
>>    9615461           +44.1%   13853485 =C2=B1  2%  =
numa-vmstat.node3.numa_local
>>     104269 =C2=B1 49%     +32.4%     138078 =C2=B1 20%  =
numa-vmstat.node3.numa_other
>>      67226 =C2=B1  4%     -12.4%      58905        =
proc-vmstat.nr_active_anon
>>     316527            -3.1%     306823        =
proc-vmstat.nr_file_pages
>>      92663            -2.9%      89935        =
proc-vmstat.nr_inactive_anon
>>      33012            +9.3%      36075 =C2=B1  2%  =
proc-vmstat.nr_kernel_stack
>>       4865           +59.3%       7749 =C2=B1  4%  =
proc-vmstat.nr_page_table_pages
>>      76214 =C2=B1  4%     -12.7%      66510        =
proc-vmstat.nr_shmem
>>      34346            +5.8%      36334        =
proc-vmstat.nr_slab_reclaimable
>>     120937           +11.5%     134852        =
proc-vmstat.nr_slab_unreclaimable
>>      67226 =C2=B1  4%     -12.4%      58905        =
proc-vmstat.nr_zone_active_anon
>>      92663            -2.9%      89935        =
proc-vmstat.nr_zone_inactive_anon
>>     152011 =C2=B1  9%     -72.0%      42500 =C2=B1 30%  =
proc-vmstat.numa_hint_faults
>>   75604538           +44.9%  1.095e+08        proc-vmstat.numa_hit
>>   75344552           +45.0%  1.093e+08        proc-vmstat.numa_local
>>     129725 =C2=B1 13%     -78.5%      27855 =C2=B1 33%  =
proc-vmstat.numa_pages_migrated
>>     440421 =C2=B1  8%     -27.0%     321634 =C2=B1 22%  =
proc-vmstat.numa_pte_updates
>>     187992 =C2=B1  4%      +5.4%     198156        =
proc-vmstat.pgactivate
>>   83223343           +45.7%  1.213e+08        =
proc-vmstat.pgalloc_normal
>>  1.056e+08           +44.3%  1.524e+08        proc-vmstat.pgfault
>>   83115624           +45.8%  1.212e+08        proc-vmstat.pgfree
>>     129725 =C2=B1 13%     -78.5%      27855 =C2=B1 33%  =
proc-vmstat.pgmigrate_success
>>   10628125           +46.1%   15525117        proc-vmstat.pgreuse
>>      13330 =C2=B1 54%    +717.2%     108933 =C2=B1 77%  =
sched_debug.cfs_rq:/.MIN_vruntime.avg
>>     184231 =C2=B1 54%    +190.7%     535537 =C2=B1 48%  =
sched_debug.cfs_rq:/.MIN_vruntime.stddev
>>       6040 =C2=B1  6%    +338.5%      26486 =C2=B1 51%  =
sched_debug.cfs_rq:/.load.avg
>>     284313 =C2=B1 37%    +159.7%     738429 =C2=B1 14%  =
sched_debug.cfs_rq:/.load.max
>>       1180 =C2=B1 35%    -100.0%       0.00        =
sched_debug.cfs_rq:/.load.min
>>      22088 =C2=B1 35%    +398.6%     110141 =C2=B1 30%  =
sched_debug.cfs_rq:/.load.stddev
>>      13330 =C2=B1 54%    +717.2%     108933 =C2=B1 77%  =
sched_debug.cfs_rq:/.max_vruntime.avg
>>     184231 =C2=B1 54%    +190.7%     535537 =C2=B1 48%  =
sched_debug.cfs_rq:/.max_vruntime.stddev
>>   16468615           -51.1%    8045534 =C2=B1 11%  =
sched_debug.cfs_rq:/.min_vruntime.avg
>>   16715699           -50.1%    8341867 =C2=B1 11%  =
sched_debug.cfs_rq:/.min_vruntime.max
>>   15817769           -51.3%    7697369 =C2=B1 11%  =
sched_debug.cfs_rq:/.min_vruntime.min
>>       0.71 =C2=B1 11%     -47.8%       0.37 =C2=B1 14%  =
sched_debug.cfs_rq:/.nr_running.avg
>>       1.17           +19.3%       1.39 =C2=B1  4%  =
sched_debug.cfs_rq:/.nr_running.max
>>       0.22 =C2=B1 35%    -100.0%       0.00        =
sched_debug.cfs_rq:/.nr_running.min
>>       0.14 =C2=B1 18%     +74.2%       0.25 =C2=B1  6%  =
sched_debug.cfs_rq:/.nr_running.stddev
>>     694.83 =C2=B1 15%     -51.9%     334.48 =C2=B1 20%  =
sched_debug.cfs_rq:/.runnable_avg.avg
>>     110.72 =C2=B1 51%     -90.4%      10.63 =C2=B1114%  =
sched_debug.cfs_rq:/.runnable_avg.min
>>     155.35 =C2=B1 11%     +42.5%     221.31 =C2=B1  9%  =
sched_debug.cfs_rq:/.runnable_avg.stddev
>>      64422 =C2=B1 94%    +295.3%     254650 =C2=B1 19%  =
sched_debug.cfs_rq:/.spread0.avg
>>     311765 =C2=B1 14%     +76.7%     550961 =C2=B1 14%  =
sched_debug.cfs_rq:/.spread0.max
>>    -587893           -84.1%     -93210        =
sched_debug.cfs_rq:/.spread0.min
>>     685.90 =C2=B1 14%     -56.7%     297.04 =C2=B1 23%  =
sched_debug.cfs_rq:/.util_avg.avg
>>     100.39 =C2=B1 59%     -90.9%       9.12 =C2=B1125%  =
sched_debug.cfs_rq:/.util_avg.min
>>     153.19 =C2=B1 12%     +28.3%     196.53 =C2=B1 12%  =
sched_debug.cfs_rq:/.util_avg.stddev
>>     398.32 =C2=B1 19%     -79.6%      81.24 =C2=B1 25%  =
sched_debug.cfs_rq:/.util_est_enqueued.avg
>>     932.06 =C2=B1  8%     -26.5%     684.67 =C2=B1 16%  =
sched_debug.cfs_rq:/.util_est_enqueued.max
>>       0.28 =C2=B1 28%    -100.0%       0.00        =
sched_debug.cfs_rq:/.util_est_enqueued.min
>>     186.70 =C2=B1 17%     -31.0%     128.84 =C2=B1 18%  =
sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>      42223 =C2=B1 22%     +72.6%      72869 =C2=B1 21%  =
sched_debug.cpu.avg_idle.min
>>     513534 =C2=B1 67%     -58.1%     214959 =C2=B1  3%  =
sched_debug.cpu.avg_idle.stddev
>>      69440 =C2=B1 18%     -53.1%      32566 =C2=B1 23%  =
sched_debug.cpu.curr->pid.avg
>>     465.44 =C2=B1 54%    -100.0%       0.00        =
sched_debug.cpu.curr->pid.min
>>       0.71 =C2=B1 11%     -40.6%       0.42 =C2=B1  9%  =
sched_debug.cpu.nr_running.avg
>>       0.22 =C2=B1 35%    -100.0%       0.00        =
sched_debug.cpu.nr_running.min
>>       0.18 =C2=B1 10%     +68.8%       0.31 =C2=B1  5%  =
sched_debug.cpu.nr_running.stddev
>>      21723 =C2=B1  2%     +35.3%      29395 =C2=B1  9%  =
sched_debug.cpu.nr_switches.avg
>>      37415 =C2=B1 16%     +23.6%      46248 =C2=B1  5%  =
sched_debug.cpu.nr_switches.max
>>      17608           +44.3%      25417 =C2=B1 10%  =
sched_debug.cpu.nr_switches.min
>>     161.39 =C2=B1 12%     +47.1%     237.34 =C2=B1 18%  =
sched_debug.cpu.nr_uninterruptible.max
>>     -54.78           +48.6%     -81.42        =
sched_debug.cpu.nr_uninterruptible.min
>>      24.07 =C2=B1  4%     +58.5%      38.15 =C2=B1 11%  =
sched_debug.cpu.nr_uninterruptible.stddev
>>      11566           +11.1%      12849        =
slabinfo.Acpi-State.active_objs
>>      11566           +11.1%      12849        =
slabinfo.Acpi-State.num_objs
>>     240075           +13.6%     272838        =
slabinfo.dentry.active_objs
>>       5793           +13.6%       6580        =
slabinfo.dentry.active_slabs
>>     243365           +13.6%     276386        =
slabinfo.dentry.num_objs
>>       5793           +13.6%       6580        =
slabinfo.dentry.num_slabs
>>     955.00 =C2=B1  9%     +16.4%       1112 =C2=B1  7%  =
slabinfo.file_lock_cache.active_objs
>>     955.00 =C2=B1  9%     +16.4%       1112 =C2=B1  7%  =
slabinfo.file_lock_cache.num_objs
>>      14271           +14.7%      16366        =
slabinfo.files_cache.active_objs
>>      14271           +14.7%      16366        =
slabinfo.files_cache.num_objs
>>     145916           +52.7%     222770 =C2=B1  2%  =
slabinfo.filp.active_objs
>>       2300           +53.0%       3519 =C2=B1  2%  =
slabinfo.filp.active_slabs
>>     147261           +53.0%     225274 =C2=B1  2%  =
slabinfo.filp.num_objs
>>       2300           +53.0%       3519 =C2=B1  2%  =
slabinfo.filp.num_slabs
>>       1319 =C2=B1 14%     +26.2%       1664 =C2=B1  8%  =
slabinfo.khugepaged_mm_slot.active_objs
>>       1319 =C2=B1 14%     +26.2%       1664 =C2=B1  8%  =
slabinfo.khugepaged_mm_slot.num_objs
>>       1037           +19.6%       1240        =
slabinfo.kmalloc-512.active_slabs
>>      66437           +19.5%      79424        =
slabinfo.kmalloc-512.num_objs
>>       1037           +19.6%       1240        =
slabinfo.kmalloc-512.num_slabs
>>     114959            +9.0%     125273        =
slabinfo.kmalloc-8.active_objs
>>       4536 =C2=B1  5%      +7.2%       4862 =C2=B1  3%  =
slabinfo.kmalloc-rcl-64.active_objs
>>       4536 =C2=B1  5%      +7.2%       4862 =C2=B1  3%  =
slabinfo.kmalloc-rcl-64.num_objs
>>      10920           +18.9%      12978        =
slabinfo.mm_struct.active_objs
>>      10920           +18.9%      12979        =
slabinfo.mm_struct.num_objs
>>       1104 =C2=B1  5%     -16.9%     917.00 =C2=B1 10%  =
slabinfo.mnt_cache.active_objs
>>       1104 =C2=B1  5%     -16.9%     917.00 =C2=B1 10%  =
slabinfo.mnt_cache.num_objs
>>       1551           +14.3%       1773 =C2=B1  2%  =
slabinfo.names_cache.active_objs
>>       1551           +14.3%       1773 =C2=B1  2%  =
slabinfo.names_cache.num_objs
>>      35694 =C2=B1  2%     +49.3%      53295 =C2=B1  4%  =
slabinfo.pid.active_objs
>>     557.00 =C2=B1  2%     +49.4%     832.25 =C2=B1  4%  =
slabinfo.pid.active_slabs
>>      35694 =C2=B1  2%     +49.3%      53295 =C2=B1  4%  =
slabinfo.pid.num_objs
>>     557.00 =C2=B1  2%     +49.4%     832.25 =C2=B1  4%  =
slabinfo.pid.num_slabs
>>       8786           +20.2%      10558        =
slabinfo.sighand_cache.active_objs
>>     590.00           +20.3%     709.75        =
slabinfo.sighand_cache.active_slabs
>>       8858           +20.3%      10654        =
slabinfo.sighand_cache.num_objs
>>     590.00           +20.3%     709.75        =
slabinfo.sighand_cache.num_slabs
>>       8502           +11.6%       9489 =C2=B1  2%  =
slabinfo.sock_inode_cache.active_objs
>>       8502           +11.6%       9489 =C2=B1  2%  =
slabinfo.sock_inode_cache.num_objs
>>      39805 =C2=B1  2%     +45.4%      57892 =C2=B1  2%  =
slabinfo.task_delay_info.active_objs
>>     780.00 =C2=B1  2%     +45.5%       1135 =C2=B1  2%  =
slabinfo.task_delay_info.active_slabs
>>      39805 =C2=B1  2%     +45.5%      57905 =C2=B1  2%  =
slabinfo.task_delay_info.num_objs
>>     780.00 =C2=B1  2%     +45.5%       1135 =C2=B1  2%  =
slabinfo.task_delay_info.num_slabs
>>       3088           +29.3%       3992 =C2=B1  2%  =
slabinfo.task_struct.active_objs
>>       3098           +29.3%       4005 =C2=B1  2%  =
slabinfo.task_struct.active_slabs
>>       3098           +29.3%       4005 =C2=B1  2%  =
slabinfo.task_struct.num_objs
>>       3098           +29.3%       4005 =C2=B1  2%  =
slabinfo.task_struct.num_slabs
>>  1.353e+10           +11.8%  1.513e+10        =
perf-stat.i.branch-instructions
>>   84012986 =C2=B1  5%     +46.6%  1.232e+08 =C2=B1  6%  =
perf-stat.i.branch-misses
>>      31.81 =C2=B1 12%     -10.8       21.01 =C2=B1 21%  =
perf-stat.i.cache-miss-rate%
>>   68723351 =C2=B1  2%     -10.6%   61409511 =C2=B1  4%  =
perf-stat.i.cache-misses
>>  2.121e+08 =C2=B1 10%     +57.2%  3.333e+08 =C2=B1  8%  =
perf-stat.i.cache-references
>>      25583 =C2=B1  2%     +51.4%      38727        =
perf-stat.i.context-switches
>>       5.21 =C2=B1  3%     -25.2%       3.90 =C2=B1  5%  =
perf-stat.i.cpi
>>     192200            +7.5%     206633        perf-stat.i.cpu-clock
>>   3.37e+11           -28.3%  2.415e+11        perf-stat.i.cpu-cycles
>>       3432           +61.5%       5541 =C2=B1  3%  =
perf-stat.i.cpu-migrations
>>       4302           -29.4%       3039 =C2=B1  8%  =
perf-stat.i.cycles-between-cache-misses
>>    2726072 =C2=B1 23%     +52.3%    4151327 =C2=B1 26%  =
perf-stat.i.dTLB-load-misses
>>  1.215e+10            +6.3%  1.292e+10        perf-stat.i.dTLB-loads
>>     941111 =C2=B1 11%     +46.9%    1382681 =C2=B1 11%  =
perf-stat.i.dTLB-store-misses
>>  2.493e+09           +48.4%  3.701e+09        perf-stat.i.dTLB-stores
>>      71.80 =C2=B1  4%      -6.7       65.13        =
perf-stat.i.iTLB-load-miss-rate%
>>    8355924 =C2=B1  6%     +47.0%   12280660 =C2=B1  7%  =
perf-stat.i.iTLB-load-misses
>>    3268044 =C2=B1 18%     +65.6%    5412376 =C2=B1  8%  =
perf-stat.i.iTLB-loads
>>  6.464e+10           +19.2%  7.704e+10        =
perf-stat.i.instructions
>>       6911 =C2=B1  3%     -32.1%       4691 =C2=B1  6%  =
perf-stat.i.instructions-per-iTLB-miss
>>       0.23           +28.9%       0.30        perf-stat.i.ipc
>>     124.96          +101.4%     251.73 =C2=B1  2%  =
perf-stat.i.major-faults
>>       1.76           -41.2%       1.03        perf-stat.i.metric.GHz
>>       0.56 =C2=B1  8%     +32.5%       0.75 =C2=B1  7%  =
perf-stat.i.metric.K/sec
>>     332691           +49.2%     496370        =
perf-stat.i.minor-faults
>>      91.27            -4.0       87.22        =
perf-stat.i.node-load-miss-rate%
>>   18748059           -13.0%   16311904 =C2=B1  3%  =
perf-stat.i.node-load-misses
>>    1587953           +50.0%    2382313        perf-stat.i.node-loads
>>      86.40            -8.3       78.07 =C2=B1  2%  =
perf-stat.i.node-store-miss-rate%
>>    9547999           -19.9%    7644037 =C2=B1  2%  =
perf-stat.i.node-store-misses
>>    1064509           +92.2%    2045699 =C2=B1  2%  =
perf-stat.i.node-stores
>>     332816           +49.2%     496622        perf-stat.i.page-faults
>>     192200            +7.5%     206633        perf-stat.i.task-clock
>>       3.25 =C2=B1  9%     +36.0%       4.42 =C2=B1  7%  =
perf-stat.overall.MPKI
>>       0.62 =C2=B1  5%      +0.2        0.83 =C2=B1  5%  =
perf-stat.overall.branch-miss-rate%
>>      32.96 =C2=B1 10%     -13.4       19.58 =C2=B1 11%  =
perf-stat.overall.cache-miss-rate%
>>       5.25           -42.4%       3.02        perf-stat.overall.cpi
>>       4953           -28.7%       3533 =C2=B1  4%  =
perf-stat.overall.cycles-between-cache-misses
>>       0.02 =C2=B1 23%      +0.0        0.03 =C2=B1 24%  =
perf-stat.overall.dTLB-load-miss-rate%
>>      72.34 =C2=B1  3%      -3.1       69.29        =
perf-stat.overall.iTLB-load-miss-rate%
>>       7868 =C2=B1  6%     -20.0%       6292 =C2=B1  7%  =
perf-stat.overall.instructions-per-iTLB-miss
>>       0.19           +73.5%       0.33        perf-stat.overall.ipc
>>      92.20            -4.8       87.37        =
perf-stat.overall.node-load-miss-rate%
>>      90.00            -9.8       80.24        =
perf-stat.overall.node-store-miss-rate%
>>   19255954           -23.1%   14811673        =
perf-stat.overall.path-length
>>  1.382e+10            +5.2%  1.454e+10        =
perf-stat.ps.branch-instructions
>>   85147082 =C2=B1  5%     +42.1%   1.21e+08 =C2=B1  5%  =
perf-stat.ps.branch-misses
>>   69832184 =C2=B1  2%      -9.6%   63144472 =C2=B1  4%  =
perf-stat.ps.cache-misses
>>  2.141e+08 =C2=B1  9%     +52.0%  3.254e+08 =C2=B1  8%  =
perf-stat.ps.cache-references
>>      25647 =C2=B1  2%     +46.2%      37498        =
perf-stat.ps.context-switches
>>  3.458e+11           -35.6%  2.227e+11        perf-stat.ps.cpu-cycles
>>       3456           +55.5%       5375 =C2=B1  4%  =
perf-stat.ps.cpu-migrations
>>    2731148 =C2=B1 22%     +50.7%    4114660 =C2=B1 24%  =
perf-stat.ps.dTLB-load-misses
>>     951612 =C2=B1 11%     +42.4%    1354727 =C2=B1 10%  =
perf-stat.ps.dTLB-store-misses
>>  2.534e+09           +43.0%  3.624e+09        =
perf-stat.ps.dTLB-stores
>>    8410006 =C2=B1  6%     +39.9%   11763281 =C2=B1  6%  =
perf-stat.ps.iTLB-load-misses
>>    3251030 =C2=B1 17%     +60.5%    5218236 =C2=B1  7%  =
perf-stat.ps.iTLB-loads
>>  6.591e+10           +11.7%  7.364e+10        =
perf-stat.ps.instructions
>>     127.07           +97.9%     251.44 =C2=B1  2%  =
perf-stat.ps.major-faults
>>     338752           +44.5%     489644        =
perf-stat.ps.minor-faults
>>   19070733           -11.1%   16952678 =C2=B1  4%  =
perf-stat.ps.node-load-misses
>>    1613838           +51.7%    2448074        perf-stat.ps.node-loads
>>    9716997           -18.4%    7933032 =C2=B1  2%  =
perf-stat.ps.node-store-misses
>>    1079544           +80.8%    1952245        =
perf-stat.ps.node-stores
>>     338879           +44.6%     489896        =
perf-stat.ps.page-faults
>>  2.009e+13           +11.5%  2.239e+13        =
perf-stat.total.instructions
>>       0.04 =C2=B1 54%    +278.3%       0.14 =C2=B1 41%  =
perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.=
link_path_walk.part
>>       0.11 =C2=B1123%    +813.3%       1.04 =C2=B1120%  =
perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.=
path_lookupat.isra
>>       0.03 =C2=B1  9%    +210.5%       0.10 =C2=B1 21%  =
perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_e=
xit_group.do_syscall_64
>>       0.17 =C2=B1 89%    +210.6%       0.52 =C2=B1 59%  =
perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall=
_64
>>       0.05 =C2=B1 34%   +1883.2%       0.91 =C2=B1 48%  =
perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>>       0.12 =C2=B1 45%    +772.8%       1.04 =C2=B1 65%  =
perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_call_function_single.[unknown]
>>       0.09 =C2=B1  9%   +1004.3%       0.97 =C2=B1 90%  =
perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_reschedule_ipi.[unknown]
>>       0.06 =C2=B1 28%    +390.8%       0.29 =C2=B1 41%  =
perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user=
_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>>       0.63 =C2=B1  7%     +80.2%       1.13 =C2=B1 21%  =
perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user=
_mode.ret_from_fork.[unknown]
>>       0.07 =C2=B1 16%    +113.1%       0.14 =C2=B1 21%  =
perf-sched.sch_delay.avg.ms.io_schedule.__lock_page_killable.filemap_fault=
.__do_fault
>>       0.01 =C2=B1  7%    +196.2%       0.02 =C2=B1 65%  =
perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>>       0.04 =C2=B1 45%    +742.5%       0.35 =C2=B1 83%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.alloc_pages_vma.wp_page_copy
>>       0.07 =C2=B1 78%     -84.3%       0.01 =C2=B1142%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.allocate_slab.___slab_alloc
>>       0.04 =C2=B1 79%   +2194.9%       0.89 =C2=B1164%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.pte_alloc_one.__pte_alloc
>>       0.07 =C2=B1 19%     -86.5%       0.01 =C2=B1 59%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__anon_v=
ma_prepare.do_fault.__handle_mm_fault
>>       0.25 =C2=B1105%     -98.2%       0.00 =C2=B1137%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.copy_pag=
e_to_iter.generic_file_buffered_read.new_sync_read
>>       0.40 =C2=B1  6%     +91.2%       0.77 =C2=B1  5%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.do_user_=
addr_fault.exc_page_fault.asm_exc_page_fault
>>       0.08 =C2=B1100%     -92.6%       0.01 =C2=B1 94%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.__anon_vma_prepare.do_anonymous_page
>>       0.03 =C2=B1 79%    +277.4%       0.12 =C2=B1 73%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.__vma_adjust.__split_vma
>>       0.01 =C2=B1 16%  +1.5e+05%       8.25 =C2=B1103%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.do_truncate.path_openat
>>       0.04 =C2=B1 19%    +318.9%       0.16 =C2=B1 44%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.unlink_anon_vmas.free_pgtables
>>       0.04 =C2=B1  7%   +1180.0%       0.51 =C2=B1145%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.unlink_file_vma.free_pgtables
>>       0.00 =C2=B1 10%     -89.3%       0.00 =C2=B1173%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.__vm_munmap.__x64_sys_munmap
>>       0.07 =C2=B1 54%    +242.3%       0.26 =C2=B1 62%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.vm_mmap_pgoff.elf_map
>>       0.03 =C2=B1 11%     -87.8%       0.00 =C2=B1 13%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.vm_mmap_pgoff.ksys_mmap_pgoff
>>       0.01 =C2=B1 49%  +1.3e+05%       8.04 =C2=B1152%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.do_=
unlinkat.do_syscall_64
>>       0.10 =C2=B1127%  +16890.4%      16.82 =C2=B1163%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.don=
e_path_create.do_linkat
>>       0.13 =C2=B1 18%    +459.3%       0.71 =C2=B1 18%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.pat=
h_openat.do_filp_open
>>       0.44 =C2=B1118%    +204.8%       1.33 =C2=B1 94%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.sca=
n_positives.dcache_readdir
>>       0.01 =C2=B1 36%   +3156.9%       0.43 =C2=B1 63%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.ste=
p_into.path_openat
>>       0.07 =C2=B1 21%    +554.5%       0.46 =C2=B1 93%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.ter=
minate_walk.path_openat
>>       0.00 =C2=B1141%  +19625.0%       0.07 =C2=B1150%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.generic_=
file_buffered_read.__kernel_read.load_elf_binary
>>       0.08 =C2=B1134%    +686.6%       0.66 =C2=B1 59%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__d_alloc.d_alloc_cursor
>>       0.04 =C2=B1 37%    +648.3%       0.33 =C2=B1 28%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.security_file_alloc.__alloc_file
>>       0.21 =C2=B1 61%     -77.6%       0.05 =C2=B1139%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.vm_area_alloc.__install_special_mapping
>>       0.30 =C2=B1 97%     -99.2%       0.00 =C2=B1 34%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.vm_area_alloc.do_brk_flags
>>       3.67 =C2=B1140%    -100.0%       0.00 =C2=B1173%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range
>>       0.05 =C2=B1 51%     +75.6%       0.09 =C2=B1 30%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc_trace.perf_event_mmap.mmap_region
>>       0.19 =C2=B1 85%     -93.9%       0.01 =C2=B1148%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc_trace.perf_event_mmap.mprotect_fixup
>>       0.01 =C2=B1 66%  +89763.4%       8.39 =C2=B1106%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mnt_want=
_write.path_openat.do_filp_open
>>       0.01 =C2=B1108%    +903.8%       0.13 =C2=B1129%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lo=
ck.futex_exec_release.exec_mm_release
>>       0.03 =C2=B1 53%     -67.5%       0.01 =C2=B1 83%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lo=
ck.futex_exit_release.exit_mm_release
>>       0.11 =C2=B1125%   +1883.9%       2.25 =C2=B1 40%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.smpboot_=
thread_fn.kthread.ret_from_fork
>>       0.01 =C2=B1 70%    -100.0%       0.00        =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.migrate_task_to.task_numa_migrate
>>       0.30 =C2=B1  3%    +308.2%       1.22 =C2=B1 26%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.sched_exec.bprm_execve
>>       0.08 =C2=B1 68%    -100.0%       0.00        =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.wait_for=
_completion.stop_two_cpus.migrate_swap
>>       0.01 =C2=B1103%    -100.0%       0.00        =
perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_re=
ad.rmap_walk_anon.try_to_unmap
>>       0.01 =C2=B1106%    -100.0%       0.00        =
perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove=
_migration_ptes.migrate_pages
>>       0.01 =C2=B1 49%   +1115.0%       0.14 =C2=B1143%  =
perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split=
_vma.__do_munmap
>>       0.03 =C2=B1 52%     -89.4%       0.00 =C2=B1107%  =
perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.anon_vma_clone.anon_=
vma_fork.dup_mmap
>>       0.02 =C2=B1 54%   +1681.5%       0.39 =C2=B1 70%  =
perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_sysca=
ll_64.entry_SYSCALL_64_after_hwframe
>>       0.01 =C2=B1 80%    +507.1%       0.09 =C2=B1 45%  =
perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy=
_process
>>       0.02 =C2=B1 24%   +1250.0%       0.26 =C2=B1 68%  =
perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.filename_create.do_l=
inkat.__x64_sys_link
>>       0.07 =C2=B1 65%     -87.3%       0.01 =C2=B1 75%  =
perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.fre=
e_pgtables.exit_mmap
>>       0.02 =C2=B1 20%    +232.6%       0.05 =C2=B1 33%  =
perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free=
_pgtables.exit_mmap
>>       0.01 =C2=B1 27%    +363.9%       0.04 =C2=B1 43%  =
perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_region=
.do_mmap
>>       0.19 =C2=B1 68%     -95.1%       0.01 =C2=B1 13%  =
perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epol=
l_wait.__x64_sys_epoll_wait
>>       0.04 =C2=B1 18%   +5366.5%       1.93 =C2=B1 40%  =
perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fo=
rk
>>       0.04 =C2=B1 39%    +464.8%       0.24 =C2=B1 60%  =
perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_fr=
om_fork
>>       0.00 =C2=B1141%  +48300.0%       0.97 =C2=B1170%  =
perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_w=
ork.lru_add_drain_all
>>       0.20 =C2=B1  7%   +1238.1%       2.63 =C2=B1 31%  =
perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>>       0.12 =C2=B1 27%     -74.7%       0.03 =C2=B1149%  =
perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.path=
_openat
>>       0.01 =C2=B1  7%   +9784.2%       1.25 =C2=B1 18%  =
perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
>>       5.01 =C2=B1 31%    +324.7%      21.26 =C2=B1 36%  =
perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.=
link_path_walk.part
>>       3.59 =C2=B1132%   +1076.4%      42.25 =C2=B1 96%  =
perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.=
path_lookupat.isra
>>      16.19 =C2=B1  7%   +1397.5%     242.51 =C2=B1 30%  =
perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_e=
xit_group.do_syscall_64
>>       9.13 =C2=B1 27%   +2518.1%     238.94 =C2=B1 62%  =
perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>>      10.04 =C2=B1 65%   +1971.0%     207.85 =C2=B1 63%  =
perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_call_function_single.[unknown]
>>       9.21 =C2=B1 61%   +2000.8%     193.58 =C2=B1 63%  =
perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_reschedule_ipi.[unknown]
>>      11.01 =C2=B1 18%    +799.2%      99.02 =C2=B1 86%  =
perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user=
_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>>      14.73 =C2=B1 13%    +265.9%      53.91 =C2=B1 26%  =
perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user=
_mode.ret_from_fork.[unknown]
>>      10.65 =C2=B1 44%    +151.1%      26.76 =C2=B1 19%  =
perf-sched.sch_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault=
.__do_fault
>>       1.21 =C2=B1 24%   +2921.4%      36.62 =C2=B1124%  =
perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>>       0.53 =C2=B1 55%   +1359.3%       7.76 =C2=B1113%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.alloc_pages_vma.wp_page_copy
>>       0.30 =C2=B1 92%     -90.7%       0.03 =C2=B1155%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.allocate_slab.___slab_alloc
>>       0.37 =C2=B1 69%   +3449.8%      13.07 =C2=B1162%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.pte_alloc_one.__pte_alloc
>>       0.48 =C2=B1 37%     -89.3%       0.05 =C2=B1102%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__anon_v=
ma_prepare.do_fault.__handle_mm_fault
>>       0.55 =C2=B1 93%     -95.3%       0.03 =C2=B1153%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__kmallo=
c_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
>>       0.97 =C2=B1 13%    +591.3%       6.72 =C2=B1119%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.change_p=
4d_range.change_protection.mprotect_fixup
>>       0.31 =C2=B1106%     -98.6%       0.00 =C2=B1137%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.copy_pag=
e_to_iter.generic_file_buffered_read.new_sync_read
>>      11.49 =C2=B1  5%     +87.8%      21.57 =C2=B1 31%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.do_user_=
addr_fault.exc_page_fault.asm_exc_page_fault
>>       0.32 =C2=B1102%     -96.0%       0.01 =C2=B1 79%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.__anon_vma_prepare.do_anonymous_page
>>       1.05 =C2=B1 98%    +478.9%       6.10 =C2=B1 82%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.__vma_adjust.__split_vma
>>       0.02 =C2=B1  5%  +1.4e+06%     217.29 =C2=B1104%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.do_truncate.path_openat
>>       1.95 =C2=B1 26%    +682.5%      15.25 =C2=B1 64%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.unlink_anon_vmas.free_pgtables
>>       0.93 =C2=B1 14%   +9721.3%      91.57 =C2=B1158%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.unlink_file_vma.free_pgtables
>>       0.00 =C2=B1 10%     -78.6%       0.00 =C2=B1173%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.__vm_munmap.__x64_sys_munmap
>>       0.24 =C2=B1 43%     -96.7%       0.01 =C2=B1 72%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.vm_mmap_pgoff.ksys_mmap_pgoff
>>       0.01 =C2=B1 28%  +8.3e+05%     113.60 =C2=B1164%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.do_=
unlinkat.do_syscall_64
>>       0.21 =C2=B1108%  +34647.0%      72.97 =C2=B1145%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.don=
e_path_create.do_linkat
>>       3.03 =C2=B1 39%   +1407.5%      45.73 =C2=B1 29%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.pat=
h_openat.do_filp_open
>>       1.22 =C2=B1 39%   +4068.4%      50.91 =C2=B1 79%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.ste=
p_into.path_openat
>>       3.38 =C2=B1 60%   +3700.6%     128.54 =C2=B1127%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.ter=
minate_walk.path_openat
>>       0.88 =C2=B1 46%    +299.6%       3.50 =C2=B1 55%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.exit_mma=
p.mmput.begin_new_exec
>>       0.00 =C2=B1141%  +22250.0%       0.30 =C2=B1167%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.generic_=
file_buffered_read.__kernel_read.load_elf_binary
>>       0.57 =C2=B1139%  +12527.6%      71.47 =C2=B1 89%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__d_alloc.d_alloc_cursor
>>       0.00 =C2=B1141%   +1525.0%       0.03 =C2=B1144%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__delayacct_tsk_init.copy_process
>>       1.73 =C2=B1 43%    +863.5%      16.71 =C2=B1 50%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.security_file_alloc.__alloc_file
>>       3.67 =C2=B1140%    -100.0%       0.00 =C2=B1173%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range
>>       3.19 =C2=B1 52%    +345.8%      14.24 =C2=B1 84%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc_trace.perf_event_mmap.mmap_region
>>       1.01 =C2=B1 99%     -91.8%       0.08 =C2=B1167%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc_trace.perf_event_mmap.mprotect_fixup
>>       0.11 =C2=B1 85%  +1.7e+05%     187.38 =C2=B1 84%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mnt_want=
_write.path_openat.do_filp_open
>>       0.05 =C2=B1130%    +602.6%       0.36 =C2=B1142%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lo=
ck.futex_exec_release.exec_mm_release
>>       0.52 =C2=B1136%  +10794.6%      57.09 =C2=B1 72%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.smpboot_=
thread_fn.kthread.ret_from_fork
>>       0.06 =C2=B1 92%    -100.0%       0.00        =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.migrate_task_to.task_numa_migrate
>>      28.50 =C2=B1 12%    +645.4%     212.48 =C2=B1 39%  =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.sched_exec.bprm_execve
>>       1.20 =C2=B1 76%    -100.0%       0.00        =
perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.wait_for=
_completion.stop_two_cpus.migrate_swap
>>       0.18 =C2=B1130%    -100.0%       0.00        =
perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_re=
ad.rmap_walk_anon.try_to_unmap
>>       0.20 =C2=B1132%    -100.0%       0.00        =
perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove=
_migration_ptes.migrate_pages
>>       1.33 =C2=B1103%     -96.9%       0.04 =C2=B1173%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlin=
k_anon_vmas.free_pgtables
>>       1.53 =C2=B1 79%   +6359.8%      98.51 =C2=B1148%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split=
_vma.__do_munmap
>>       2.57 =C2=B1 63%    +676.1%      19.92 =C2=B1 49%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split=
_vma.mprotect_fixup
>>       0.78 =C2=B1 76%     -99.2%       0.01 =C2=B1138%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.anon_vma_clone.anon_=
vma_fork.dup_mmap
>>       0.19 =C2=B1 94%     -97.6%       0.00 =C2=B1100%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.anon_vma_fork.dup_mm=
ap.dup_mm
>>       5.70 =C2=B1 45%   +1878.3%     112.68 =C2=B1 89%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_sysca=
ll_64.entry_SYSCALL_64_after_hwframe
>>       3.68 =C2=B1111%   +1530.5%      60.07 =C2=B1 26%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy=
_process
>>       6.33 =C2=B1 17%   +2353.2%     155.41 =C2=B1105%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.filename_create.do_l=
inkat.__x64_sys_link
>>       2.23 =C2=B1 66%     -98.3%       0.04 =C2=B1 65%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.fre=
e_pgtables.exit_mmap
>>       6.50 =C2=B1 41%    +643.0%      48.28 =C2=B1 78%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free=
_pgtables.exit_mmap
>>       2.45 =C2=B1 43%   +1688.6%      43.80 =C2=B1 88%  =
perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region=
.do_mmap
>>       9.31 =C2=B1 80%     -99.6%       0.04 =C2=B1 54%  =
perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epol=
l_wait.__x64_sys_epoll_wait
>>       0.52 =C2=B1 65%  +15185.6%      79.99 =C2=B1 38%  =
perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fo=
rk
>>      16.34 =C2=B1 98%    +385.7%      79.39 =C2=B1 79%  =
perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_fr=
om_fork
>>       0.00 =C2=B1141%  +72153.1%       1.93 =C2=B1171%  =
perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_w=
ork.lru_add_drain_all
>>      10.28 =C2=B1 58%   +2363.0%     253.08 =C2=B1 17%  =
perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>>       8.41 =C2=B1 37%   +3406.7%     295.08 =C2=B1 29%  =
perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
>>       0.12 =C2=B1 74%    +358.2%       0.54 =C2=B1 29%  =
perf-sched.total_sch_delay.average.ms
>>      39.70 =C2=B1  3%     -15.2%      33.67 =C2=B1  3%  =
perf-sched.total_wait_and_delay.average.ms
>>     157875 =C2=B1  3%     +29.4%     204320 =C2=B1  3%  =
perf-sched.total_wait_and_delay.count.ms
>>       5585           +14.5%       6395 =C2=B1  3%  =
perf-sched.total_wait_and_delay.max.ms
>>      39.58 =C2=B1  3%     -16.3%      33.13 =C2=B1  3%  =
perf-sched.total_wait_time.average.ms
>>       5585           +14.5%       6395 =C2=B1  3%  =
perf-sched.total_wait_time.max.ms
>>       6.67 =C2=B1  2%     +90.8%      12.72 =C2=B1 10%  =
perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_sy=
scall_64
>>       6.25 =C2=B1 22%    +706.2%      50.40 =C2=B1 54%  =
perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_t=
o_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>>       6.09 =C2=B1 15%    -100.0%       0.00        =
perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to=
_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>>      38.34 =C2=B1 13%     +47.7%      56.61 =C2=B1 33%  =
perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_rea=
d
>>       5.09           +14.7%       5.83 =C2=B1  3%  =
perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.sto=
p_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
>>       0.33 =C2=B1  3%    +330.6%       1.42 =C2=B1 24%  =
perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.sto=
p_one_cpu.sched_exec.bprm_execve
>>       1.33 =C2=B1 20%    +419.5%       6.93 =C2=B1  7%  =
perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_=
syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.60 =C2=B1 70%    +168.1%       1.61 =C2=B1 18%  =
perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm=
.copy_process
>>       3.71 =C2=B1 11%     +29.9%       4.82 =C2=B1 12%  =
perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_=
filp_open.do_sys_openat2
>>       0.04 =C2=B1141%    +440.1%       0.24 =C2=B1 12%  =
perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma=
.free_pgtables.unmap_region
>>       0.06 =C2=B1141%    +604.1%       0.41 =C2=B1 20%  =
perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_r=
egion.do_mmap
>>     251.31 =C2=B1  7%     -36.4%     159.76 =C2=B1 18%  =
perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do=
_epoll_wait.__x64_sys_epoll_wait
>>      87.92 =C2=B1 14%     +50.7%     132.47 =C2=B1 22%  =
perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_sched=
ule_timeout.constprop.0.do_sys_poll
>>     384.15           -32.3%     260.23 =C2=B1 10%  =
perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>>     142.29           -30.8%      98.47 =C2=B1  6%  =
perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
>>      35.67 =C2=B1 11%     +58.4%      56.50        =
perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall=
_64
>>      14.67 =C2=B1  8%     +19.3%      17.50 =C2=B1  4%  =
perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_n=
anosleep.do_syscall_64
>>      35.67 =C2=B1  9%     +58.4%      56.50        =
perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
>>      39991           +28.3%      51295 =C2=B1  4%  =
perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_s=
ys_exit_group.do_syscall_64
>>      41076           +26.8%      52088 =C2=B1  4%  =
perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_sys=
call_64
>>     914.67 =C2=B1  2%     +68.3%       1539 =C2=B1  6%  =
perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to=
_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>>     122.33 =C2=B1141%    +401.1%     613.00 =C2=B1 22%  =
perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to=
_user_mode.asm_sysvec_reschedule_ipi.[unknown]
>>       1649 =C2=B1  8%    -100.0%       0.00        =
perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_=
user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>>       4728 =C2=B1 13%     -91.3%     412.00 =C2=B1100%  =
perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.dput=
.scan_positives.dcache_readdir
>>       4.67 =C2=B1 44%   +1325.0%      66.50 =C2=B1 51%  =
perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.smpb=
oot_thread_fn.kthread.ret_from_fork
>>       1987 =C2=B1  4%     -13.4%       1720 =C2=B1  4%  =
perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.stop=
_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
>>       3064 =C2=B1  8%     +76.6%       5412 =C2=B1 13%  =
perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.stop=
_one_cpu.sched_exec.bprm_execve
>>       2046 =C2=B1  7%     +68.3%       3443 =C2=B1 15%  =
perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.walk_component.pa=
th_lookupat.isra.0
>>     896.33 =C2=B1  5%     +81.3%       1625 =C2=B1 12%  =
perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.do_s=
yscall_64.entry_SYSCALL_64_after_hwframe
>>     776.00 =C2=B1 75%    +292.9%       3049 =C2=B1 44%  =
perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.dup_mmap.dup_mm.=
copy_process
>>       1649 =C2=B1 32%    +198.7%       4926 =C2=B1 45%  =
perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_file_vma.=
free_pgtables.exit_mmap
>>     354.67 =C2=B1141%    +482.9%       2067 =C2=B1 36%  =
perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_file_vma.=
free_pgtables.unmap_region
>>     350.00 =C2=B1141%    +496.1%       2086 =C2=B1 33%  =
perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.vma_link.mmap_re=
gion.do_mmap
>>      13.00 =C2=B1 21%     +61.5%      21.00        =
perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedu=
le_timeout.constprop.0.do_select
>>     163.67 =C2=B1  3%     -35.2%     106.00 =C2=B1 25%  =
perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedu=
le_timeout.constprop.0.do_sys_poll
>>       1762 =C2=B1  4%     -17.5%       1454 =C2=B1 12%  =
perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.re=
t_from_fork
>>       9129 =C2=B1  2%     +43.1%      13062 =C2=B1  9%  =
perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
>>      12642           +52.2%      19242 =C2=B1  3%  =
perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
>>       5512           -30.9%       3811        =
perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscal=
l_64
>>       5512           -30.9%       3811        =
perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
>>     340.62 =C2=B1141%    +203.4%       1033        =
perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_t=
o_user_mode.asm_sysvec_reschedule_ipi.[unknown]
>>       5496          -100.0%       0.00        =
perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to=
_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>>       5580           -30.1%       3899        =
perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_rea=
d
>>       1495 =C2=B1 31%    +114.1%       3203 =C2=B1  4%  =
perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.smp=
boot_thread_fn.kthread.ret_from_fork
>>      28.50 =C2=B1 12%    +645.4%     212.48 =C2=B1 39%  =
perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.sto=
p_one_cpu.sched_exec.bprm_execve
>>      20.64 =C2=B1 78%   +2946.5%     628.69 =C2=B1 62%  =
perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm=
.copy_process
>>      20.38 =C2=B1 28%    +299.0%      81.32 =C2=B1 53%  =
perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma=
.free_pgtables.exit_mmap
>>       3.90 =C2=B1141%    +526.7%      24.46 =C2=B1 34%  =
perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma=
.free_pgtables.unmap_region
>>       3.78 =C2=B1141%   +1570.8%      63.11 =C2=B1 45%  =
perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_r=
egion.do_mmap
>>       5176           -31.0%       3569        =
perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do=
_epoll_wait.__x64_sys_epoll_wait
>>       5585           -30.2%       3899        =
perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_sched=
ule_timeout.constprop.0.do_select
>>     505.28           +31.3%     663.68 =C2=B1  9%  =
perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_fr=
om_fork
>>       4817 =C2=B1 15%     -31.2%       3315 =C2=B1  3%  =
perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>>       1791           -16.1%       1502 =C2=B1  3%  =
perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
>>       0.08 =C2=B1 39%    +460.9%       0.43 =C2=B1 27%  =
perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.=
link_path_walk.part
>>       0.17 =C2=B1 92%    +182.7%       0.48 =C2=B1 59%  =
perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.=
path_lookupat.isra
>>       6.50 =C2=B1  3%     +87.7%      12.20 =C2=B1  8%  =
perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall=
_64
>>       0.59 =C2=B1123%    +129.1%       1.35 =C2=B1 86%  =
perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_exc_page_fault.[unknown]
>>       6.21 =C2=B1 22%    +697.5%      49.49 =C2=B1 55%  =
perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>>       8.60 =C2=B1 95%    +175.7%      23.70 =C2=B1 34%  =
perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_call_function_single.[unknown]
>>       6.03 =C2=B1 15%    +354.9%      27.43 =C2=B1 13%  =
perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user=
_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>>       0.00 =C2=B1 88%  +24178.6%       1.13 =C2=B1156%  =
perf-sched.wait_time.avg.ms.io_schedule.__lock_page.__do_fault.do_fault
>>      38.33 =C2=B1 13%     +47.6%      56.59 =C2=B1 33%  =
perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>>       0.53 =C2=B1120%     -98.4%       0.01 =C2=B1102%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.__pmd_alloc.__handle_mm_fault
>>       0.01 =C2=B1115%   +6617.2%       0.36 =C2=B1168%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmallo=
c.load_elf_phdrs.load_elf_binary
>>       0.42 =C2=B1 44%    +593.4%       2.89 =C2=B1 57%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmallo=
c.security_task_alloc.copy_process
>>       0.08 =C2=B1 57%    +614.6%       0.60 =C2=B1 48%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__put_an=
on_vma.unlink_anon_vmas.free_pgtables
>>       0.27 =C2=B1140%    +525.8%       1.67 =C2=B1 86%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.cgroup_c=
an_fork.copy_process.kernel_clone
>>       0.05 =C2=B1 25%    +978.8%       0.50 =C2=B1 50%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.change_p=
4d_range.change_protection.mprotect_fixup
>>       0.53 =C2=B1 73%    +685.8%       4.14 =C2=B1 66%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy_pte=
_range.copy_page_range.dup_mmap
>>       0.02 =C2=B1123%   +6830.4%       1.59 =C2=B1103%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_rea=
d.path_openat.do_filp_open
>>       0.06 =C2=B1 29%    +796.1%       0.51 =C2=B1 93%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_rea=
d.walk_component.link_path_walk
>>       0.01 =C2=B1141%   +2254.2%       0.14 =C2=B1161%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_rea=
d_killable.create_elf_tables.isra
>>       0.01 =C2=B1 97%   +9626.4%       1.13 =C2=B1 62%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.__anon_vma_prepare.do_fault
>>       0.02 =C2=B1 87%   +4118.8%       0.79 =C2=B1 55%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.__vma_adjust.shift_arg_pages
>>       1.50 =C2=B1 68%   +1104.7%      18.05 =C2=B1100%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.anon_vma_fork.dup_mmap
>>       2.02 =C2=B1 13%    +454.8%      11.23 =C2=B1 69%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.do_truncate.path_openat
>>       1.78 =C2=B1 66%    +587.5%      12.24 =C2=B1 99%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.dup_mmap.dup_mm
>>       0.86 =C2=B1 39%     +37.3%       1.18 =C2=B1 11%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.unlink_file_vma.free_pgtables
>>       0.01 =C2=B1141%   +3608.3%       0.22 =C2=B1 85%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.__vm_munmap.elf_map
>>       0.01 =C2=B1135%    +539.5%       0.08 =C2=B1 83%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.vm_brk_flags.load_elf_interp
>>       0.04 =C2=B1 21%    +251.3%       0.14 =C2=B1 50%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.vm_mmap_pgoff.elf_map
>>       0.25 =C2=B1 70%   +1512.8%       4.09 =C2=B1132%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.__f=
put.task_work_run
>>       0.18 =C2=B1139%   +1040.9%       2.06 =C2=B1 93%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.dca=
che_dir_close.__fput
>>       0.32 =C2=B1 75%   +3385.1%      11.30 =C2=B1101%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.do_=
unlinkat.do_syscall_64
>>       9.06 =C2=B1 10%    +226.6%      29.60 =C2=B1 20%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.sca=
n_positives.dcache_readdir
>>       2.19 =C2=B1119%    +216.9%       6.95 =C2=B1 21%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.ste=
p_into.path_openat
>>       0.16 =C2=B1 19%   +1845.7%       3.15 =C2=B1 29%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.ter=
minate_walk.path_openat
>>       0.03 =C2=B1 70%   +2914.6%       0.82 =C2=B1 63%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit_mma=
p.mmput.begin_new_exec
>>       0.97 =C2=B1 23%    +131.5%       2.24 =C2=B1 56%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit_mma=
p.mmput.do_exit
>>       0.01 =C2=B1126%    +319.3%       0.06 =C2=B1 53%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__anon_vma_prepare.do_anonymous_page
>>       0.04 =C2=B1 15%   +2327.3%       0.89 =C2=B1 54%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__d_alloc.d_alloc
>>       0.62 =C2=B1 70%   +3428.4%      21.95 =C2=B1 35%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__d_alloc.d_alloc_cursor
>>       0.29 =C2=B1 72%   +1816.0%       5.56 =C2=B1 89%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.copy_fs_struct.copy_process
>>       0.05 =C2=B1119%   +1698.6%       0.95 =C2=B1 91%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.getname_flags.do_sys_openat2
>>       0.18 =C2=B1 72%    +533.7%       1.16 =C2=B1 31%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.getname_flags.user_path_at_empty
>>       0.41 =C2=B1 34%    +890.7%       4.09 =C2=B1 49%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.prepare_creds.copy_creds
>>       3.70 =C2=B1 18%     +55.5%       5.76 =C2=B1 42%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.vm_area_dup.dup_mmap
>>      10.64 =C2=B1105%    +189.5%      30.81 =C2=B1 66%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mnt_want=
_write.path_openat.do_filp_open
>>       0.10 =C2=B1 68%    -100.0%       0.00        =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lo=
ck_killable.begin_new_exec.load_elf_binary
>>       0.05 =C2=B1 97%   +1166.8%       0.58 =C2=B1 67%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.remove_v=
ma.__do_munmap.__vm_munmap
>>       5.09           +14.7%       5.83 =C2=B1  3%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.__set_cpus_allowed_ptr.sched_setaffinity
>>       2.90 =C2=B1 20%    -100.0%       0.00        =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.migrate_task_to.task_numa_migrate
>>       0.03 =C2=B1  5%    +539.8%       0.20 =C2=B1 26%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.sched_exec.bprm_execve
>>       2.38 =C2=B1 18%    -100.0%       0.00        =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.wait_for=
_completion.stop_two_cpus.migrate_swap
>>       0.23 =C2=B1  2%     +87.1%       0.44 =C2=B1 35%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.zap_pte_=
range.unmap_page_range.unmap_vmas
>>       2.62 =C2=B1 44%    -100.0%       0.00        =
perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_re=
ad.rmap_walk_anon.try_to_unmap
>>       2.41 =C2=B1 41%    -100.0%       0.00        =
perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove=
_migration_ptes.migrate_pages
>>       0.17 =C2=B1  4%     +96.1%       0.34 =C2=B1 48%  =
perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split=
_vma.mprotect_fixup
>>       1.31 =C2=B1 21%    +398.6%       6.54 =C2=B1  7%  =
perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_sysca=
ll_64.entry_SYSCALL_64_after_hwframe
>>       0.93 =C2=B1  7%     +64.0%       1.53 =C2=B1 16%  =
perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy=
_process
>>       0.17 =C2=B1 14%     +31.3%       0.22 =C2=B1 13%  =
perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free=
_pgtables.unmap_region
>>       0.20 =C2=B1 15%     +83.9%       0.37 =C2=B1 25%  =
perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_region=
.do_mmap
>>     251.12 =C2=B1  7%     -36.4%     159.75 =C2=B1 18%  =
perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epol=
l_wait.__x64_sys_epoll_wait
>>      87.92 =C2=B1 14%     +50.6%     132.37 =C2=B1 23%  =
perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_t=
imeout.constprop.0.do_sys_poll
>>     383.96           -32.9%     257.59 =C2=B1  9%  =
perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>>     142.28           -31.7%      97.22 =C2=B1  6%  =
perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
>>       8.16 =C2=B1 46%    +383.8%      39.47 =C2=B1 75%  =
perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.=
link_path_walk.part
>>       5512           -30.9%       3811        =
perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>>       5512           -30.9%       3811        =
perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
>>       5496           -30.6%       3813        =
perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user=
_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>>       0.07 =C2=B1107%  +29156.2%      21.16 =C2=B1159%  =
perf-sched.wait_time.max.ms.io_schedule.__lock_page.__do_fault.do_fault
>>       5580           -30.1%       3899        =
perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>>       4.62 =C2=B1 40%    +343.5%      20.48 =C2=B1 14%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmallo=
c.security_task_alloc.copy_process
>>       2.87 =C2=B1 85%    +498.7%      17.16 =C2=B1 34%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__put_an=
on_vma.unlink_anon_vmas.free_pgtables
>>       1.03 =C2=B1140%    +525.1%       6.42 =C2=B1 54%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.cgroup_c=
an_fork.copy_process.kernel_clone
>>       0.85 =C2=B1 22%   +2220.1%      19.71 =C2=B1 82%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.change_p=
4d_range.change_protection.mprotect_fixup
>>       7.98 =C2=B1 62%    +586.9%      54.83 =C2=B1100%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_pte=
_range.copy_page_range.dup_mmap
>>       0.42 =C2=B1 73%    +476.2%       2.44 =C2=B1 95%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_str=
ings.isra.0
>>       0.18 =C2=B1131%   +4103.5%       7.45 =C2=B1 88%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_rea=
d.path_openat.do_filp_open
>>       2.68 =C2=B1 50%   +1905.1%      53.65 =C2=B1123%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_rea=
d.walk_component.link_path_walk
>>       0.04 =C2=B1141%   +3772.9%       1.39 =C2=B1166%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_rea=
d_killable.create_elf_tables.isra
>>       0.03 =C2=B1122%  +22698.3%       6.76 =C2=B1 88%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.__anon_vma_prepare.do_fault
>>       0.25 =C2=B1103%   +3843.4%       9.87 =C2=B1 62%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.__vma_adjust.shift_arg_pages
>>      23.74 =C2=B1 13%   +1153.9%     297.72 =C2=B1136%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.anon_vma_clone.anon_vma_fork
>>       8.46 =C2=B1 76%   +3275.9%     285.49 =C2=B1146%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.anon_vma_fork.dup_mmap
>>       8.55 =C2=B1 14%   +2664.7%     236.39 =C2=B1 90%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.do_truncate.path_openat
>>       0.02 =C2=B1141%   +3120.9%       0.78 =C2=B1 90%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.__vm_munmap.elf_map
>>       0.63 =C2=B1 47%    +456.1%       3.51 =C2=B1 76%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_wri=
te_killable.vm_mmap_pgoff.elf_map
>>       0.36 =C2=B1139%    +758.2%       3.10 =C2=B1 66%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.dca=
che_dir_close.__fput
>>       1.91 =C2=B1 89%   +6827.3%     132.20 =C2=B1137%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.do_=
unlinkat.do_syscall_64
>>     336.18 =C2=B1140%     +73.0%     581.60 =C2=B1 78%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.don=
e_path_create.do_linkat
>>     341.13 =C2=B1137%    +196.8%       1012        =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.ste=
p_into.path_openat
>>       9.64 =C2=B1 52%   +4704.9%     463.29 =C2=B1 72%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.ter=
minate_walk.path_openat
>>       0.94 =C2=B1 71%   +1718.2%      17.05 =C2=B1 33%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_mma=
p.mmput.begin_new_exec
>>       6.94 =C2=B1 41%    +683.1%      54.36 =C2=B1113%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_mma=
p.mmput.do_exit
>>       0.07 =C2=B1119%    +888.4%       0.65 =C2=B1 80%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__anon_vma_prepare.do_anonymous_page
>>       0.42 =C2=B1 51%   +3060.9%      13.37 =C2=B1 71%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__d_alloc.d_alloc
>>       1.61 =C2=B1 71%  +29984.9%     484.07 =C2=B1 65%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__d_alloc.d_alloc_cursor
>>       1.01 =C2=B1 76%    +779.3%       8.90 =C2=B1 68%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.copy_fs_struct.copy_process
>>       1.25 =C2=B1 73%    +327.5%       5.36 =C2=B1 28%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.getname_flags.user_path_at_empty
>>      23.94 =C2=B1 16%    +259.0%      85.92 =C2=B1 53%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.vm_area_dup.dup_mmap
>>       6.01 =C2=B1 27%     +52.0%       9.13 =C2=B1 24%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc_trace.perf_event_mmap.mmap_region
>>       0.27 =C2=B1 77%    -100.0%       0.00        =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lo=
ck_killable.begin_new_exec.load_elf_binary
>>       0.41 =C2=B1 97%   +1470.1%       6.36 =C2=B1 97%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_v=
ma.__do_munmap.__vm_munmap
>>       2.81 =C2=B1 79%    +146.3%       6.92 =C2=B1 44%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_v=
ma.__do_munmap.mmap_region
>>       7.51 =C2=B1 23%    +226.7%      24.54 =C2=B1 98%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_v=
ma.exit_mmap.mmput
>>       7.36 =C2=B1116%    +497.6%      44.00 =C2=B1 94%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.shmem_un=
do_range.shmem_truncate_range.shmem_evict_inode
>>       1495 =C2=B1 31%    +114.1%       3203 =C2=B1  4%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.smpboot_=
thread_fn.kthread.ret_from_fork
>>       9.21 =C2=B1 22%    -100.0%       0.00        =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.migrate_task_to.task_numa_migrate
>>      12.64 =C2=B1  2%    +300.8%      50.66 =C2=B1 43%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one=
_cpu.sched_exec.bprm_execve
>>       7.61 =C2=B1 29%    -100.0%       0.00        =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.wait_for=
_completion.stop_two_cpus.migrate_swap
>>      20.69 =C2=B1 50%    -100.0%       0.00        =
perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_re=
ad.rmap_walk_anon.try_to_unmap
>>      19.13 =C2=B1 36%    -100.0%       0.00        =
perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove=
_migration_ptes.migrate_pages
>>       2.03 =C2=B1 55%     -96.2%       0.08 =C2=B1151%  =
perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlin=
k_anon_vmas.free_pgtables
>>       7.53 =C2=B1 25%    +397.1%      37.43 =C2=B1 76%  =
perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split=
_vma.mprotect_fixup
>>      31.44 =C2=B1 23%   +1888.2%     625.17 =C2=B1 62%  =
perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy=
_process
>>       2.32 =C2=B1 99%     -88.3%       0.27 =C2=B1 87%  =
perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.fre=
e_pgtables.exit_mmap
>>      20.37 =C2=B1 28%    +184.7%      57.99 =C2=B1 80%  =
perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free=
_pgtables.exit_mmap
>>      11.76 =C2=B1 17%    +170.3%      31.80 =C2=B1 43%  =
perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region=
.do_mmap
>>       5176           -31.0%       3569        =
perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epol=
l_wait.__x64_sys_epoll_wait
>>       5585           -30.2%       3899        =
perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_t=
imeout.constprop.0.do_select
>>     505.14           +15.5%     583.69 =C2=B1  5%  =
perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fo=
rk
>>       4816 =C2=B1 15%     -31.5%       3297 =C2=B1  3%  =
perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>>       1791           -20.7%       1420 =C2=B1  3%  =
perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
>>      29455 =C2=B1  2%     +33.9%      39449 =C2=B1  7%  =
softirqs.CPU0.NET_RX
>>      25470           +32.0%      33628        softirqs.CPU0.SCHED
>>      26529 =C2=B1 11%     +43.7%      38110 =C2=B1  9%  =
softirqs.CPU1.NET_RX
>>      22797 =C2=B1  3%     +43.8%      32782 =C2=B1  3%  =
softirqs.CPU1.SCHED
>>      28371 =C2=B1  3%     +54.2%      43762 =C2=B1 13%  =
softirqs.CPU10.NET_RX
>>      22629 =C2=B1  2%     +43.4%      32439 =C2=B1  2%  =
softirqs.CPU10.SCHED
>>      27171 =C2=B1  4%     +38.4%      37593 =C2=B1  9%  =
softirqs.CPU100.NET_RX
>>      23180 =C2=B1  2%     +39.1%      32248        =
softirqs.CPU100.SCHED
>>      28196 =C2=B1  2%     +34.4%      37895 =C2=B1  5%  =
softirqs.CPU101.NET_RX
>>      23100           +40.7%      32511 =C2=B1  2%  =
softirqs.CPU101.SCHED
>>      27883 =C2=B1  3%     +43.5%      40015 =C2=B1 11%  =
softirqs.CPU102.NET_RX
>>      22937 =C2=B1  2%     +41.4%      32444 =C2=B1  2%  =
softirqs.CPU102.SCHED
>>      28037           +40.7%      39461 =C2=B1  7%  =
softirqs.CPU103.NET_RX
>>      23000 =C2=B1  2%     +41.0%      32435 =C2=B1  2%  =
softirqs.CPU103.SCHED
>>      28345           +34.9%      38229 =C2=B1  9%  =
softirqs.CPU104.NET_RX
>>      22314 =C2=B1  3%     +45.3%      32417 =C2=B1  2%  =
softirqs.CPU104.SCHED
>>      27097 =C2=B1  2%     +40.7%      38114 =C2=B1  3%  =
softirqs.CPU105.NET_RX
>>      22615 =C2=B1  2%     +42.8%      32294 =C2=B1  2%  =
softirqs.CPU105.SCHED
>>      26463 =C2=B1  3%     +50.9%      39943 =C2=B1 12%  =
softirqs.CPU106.NET_RX
>>      22730 =C2=B1  2%     +42.2%      32319 =C2=B1  2%  =
softirqs.CPU106.SCHED
>>      27957 =C2=B1  2%     +29.0%      36058 =C2=B1  6%  =
softirqs.CPU107.NET_RX
>>      22901 =C2=B1  2%     +41.3%      32362 =C2=B1  2%  =
softirqs.CPU107.SCHED
>>      29320 =C2=B1  8%     +33.4%      39101 =C2=B1 10%  =
softirqs.CPU108.NET_RX
>>      22873 =C2=B1  2%     +41.2%      32301 =C2=B1  2%  =
softirqs.CPU108.SCHED
>>      29106 =C2=B1  2%     +31.5%      38266 =C2=B1  3%  =
softirqs.CPU109.NET_RX
>>      22591 =C2=B1  2%     +43.1%      32336        =
softirqs.CPU109.SCHED
>>      28741 =C2=B1  5%     +34.6%      38676 =C2=B1  6%  =
softirqs.CPU11.NET_RX
>>      22399 =C2=B1  3%     +44.5%      32364 =C2=B1  2%  =
softirqs.CPU11.SCHED
>>      26804 =C2=B1  5%     +41.8%      38006 =C2=B1  5%  =
softirqs.CPU110.NET_RX
>>      22766 =C2=B1  2%     +43.3%      32619 =C2=B1  2%  =
softirqs.CPU110.SCHED
>>      25623 =C2=B1  7%     +45.9%      37393 =C2=B1  9%  =
softirqs.CPU111.NET_RX
>>      22586 =C2=B1  2%     +43.4%      32391 =C2=B1  2%  =
softirqs.CPU111.SCHED
>>      28020 =C2=B1  6%     +31.8%      36917 =C2=B1  7%  =
softirqs.CPU112.NET_RX
>>      22741           +42.2%      32349 =C2=B1  2%  =
softirqs.CPU112.SCHED
>>      28310 =C2=B1  7%     +35.1%      38234 =C2=B1 12%  =
softirqs.CPU113.NET_RX
>>      22884 =C2=B1  2%     +42.4%      32577 =C2=B1  2%  =
softirqs.CPU113.SCHED
>>      25668 =C2=B1  5%     +45.9%      37457 =C2=B1  7%  =
softirqs.CPU114.NET_RX
>>      22706 =C2=B1  3%     +41.7%      32178        =
softirqs.CPU114.SCHED
>>      28637 =C2=B1  5%     +37.6%      39418 =C2=B1  6%  =
softirqs.CPU115.NET_RX
>>      22796           +41.0%      32139        softirqs.CPU115.SCHED
>>      26953 =C2=B1  7%     +42.1%      38291 =C2=B1  7%  =
softirqs.CPU116.NET_RX
>>      22646           +42.1%      32171 =C2=B1  2%  =
softirqs.CPU116.SCHED
>>      28477 =C2=B1  8%     +35.4%      38544 =C2=B1  3%  =
softirqs.CPU117.NET_RX
>>      22866 =C2=B1  2%     +40.8%      32189 =C2=B1  2%  =
softirqs.CPU117.SCHED
>>      27445 =C2=B1  7%     +40.9%      38675 =C2=B1 11%  =
softirqs.CPU118.NET_RX
>>      22902           +41.4%      32386 =C2=B1  2%  =
softirqs.CPU118.SCHED
>>      26884 =C2=B1  4%     +38.3%      37182 =C2=B1  6%  =
softirqs.CPU119.NET_RX
>>      22721 =C2=B1  2%     +42.0%      32265 =C2=B1  2%  =
softirqs.CPU119.SCHED
>>      28376 =C2=B1  9%     +36.6%      38767 =C2=B1  9%  =
softirqs.CPU12.NET_RX
>>      22706 =C2=B1  3%     +40.4%      31877 =C2=B1  2%  =
softirqs.CPU12.SCHED
>>      27315 =C2=B1  7%     +45.1%      39644 =C2=B1  4%  =
softirqs.CPU120.NET_RX
>>      23157 =C2=B1  2%     +38.9%      32175        =
softirqs.CPU120.SCHED
>>      26387 =C2=B1  5%     +51.6%      40015 =C2=B1  4%  =
softirqs.CPU121.NET_RX
>>      22856           +38.5%      31646        softirqs.CPU121.SCHED
>>      25176 =C2=B1  7%     +67.6%      42194 =C2=B1  4%  =
softirqs.CPU122.NET_RX
>>      22775           +40.3%      31962        softirqs.CPU122.SCHED
>>      25636 =C2=B1  5%     +60.8%      41225 =C2=B1  7%  =
softirqs.CPU123.NET_RX
>>      23322           +37.7%      32124        softirqs.CPU123.SCHED
>>      29777 =C2=B1  2%     +37.4%      40911 =C2=B1  3%  =
softirqs.CPU124.NET_RX
>>      23141 =C2=B1  2%     +38.7%      32098        =
softirqs.CPU124.SCHED
>>      25720 =C2=B1  7%     +53.0%      39356 =C2=B1  4%  =
softirqs.CPU125.NET_RX
>>      23140 =C2=B1  3%     +38.7%      32104        =
softirqs.CPU125.SCHED
>>      27106 =C2=B1  2%     +44.7%      39214 =C2=B1  2%  =
softirqs.CPU126.NET_RX
>>      33141 =C2=B1  3%     +11.4%      36924 =C2=B1  7%  =
softirqs.CPU126.RCU
>>      23154 =C2=B1  2%     +38.6%      32083        =
softirqs.CPU126.SCHED
>>      25748 =C2=B1  4%     +53.8%      39601 =C2=B1  8%  =
softirqs.CPU127.NET_RX
>>      23011 =C2=B1  2%     +39.4%      32068        =
softirqs.CPU127.SCHED
>>      28647 =C2=B1 11%     +42.1%      40718        =
softirqs.CPU128.NET_RX
>>      34186 =C2=B1  3%     +11.6%      38137 =C2=B1  7%  =
softirqs.CPU128.RCU
>>      23173 =C2=B1  2%     +38.2%      32016        =
softirqs.CPU128.SCHED
>>      27101 =C2=B1  3%     +48.6%      40259 =C2=B1  5%  =
softirqs.CPU129.NET_RX
>>      22818           +40.4%      32045        softirqs.CPU129.SCHED
>>      31534 =C2=B1 12%     +25.9%      39696 =C2=B1 10%  =
softirqs.CPU13.NET_RX
>>      22674 =C2=B1  2%     +41.6%      32108 =C2=B1  2%  =
softirqs.CPU13.SCHED
>>      27452           +48.9%      40871 =C2=B1  2%  =
softirqs.CPU130.NET_RX
>>      23203           +37.1%      31807 =C2=B1  2%  =
softirqs.CPU130.SCHED
>>      26896 =C2=B1  3%     +51.9%      40860 =C2=B1  4%  =
softirqs.CPU131.NET_RX
>>      23148 =C2=B1  2%     +37.4%      31814        =
softirqs.CPU131.SCHED
>>      28393 =C2=B1  3%     +41.2%      40084 =C2=B1  7%  =
softirqs.CPU132.NET_RX
>>      23200           +36.7%      31706        softirqs.CPU132.SCHED
>>      26482 =C2=B1  3%     +54.4%      40891 =C2=B1  3%  =
softirqs.CPU133.NET_RX
>>      22970           +41.0%      32382 =C2=B1  2%  =
softirqs.CPU133.SCHED
>>      26774 =C2=B1  7%     +44.7%      38735 =C2=B1  5%  =
softirqs.CPU134.NET_RX
>>      33646           +10.7%      37240 =C2=B1  7%  =
softirqs.CPU134.RCU
>>      23088 =C2=B1  2%     +38.6%      32008        =
softirqs.CPU134.SCHED
>>      26666           +54.1%      41081 =C2=B1  7%  =
softirqs.CPU135.NET_RX
>>      33456 =C2=B1  4%     +14.0%      38141 =C2=B1  8%  =
softirqs.CPU135.RCU
>>      22804           +40.0%      31925        softirqs.CPU135.SCHED
>>      26562 =C2=B1  5%     +55.4%      41276 =C2=B1  7%  =
softirqs.CPU136.NET_RX
>>      23134 =C2=B1  3%     +38.9%      32141        =
softirqs.CPU136.SCHED
>>      25297 =C2=B1  4%     +62.9%      41210 =C2=B1  6%  =
softirqs.CPU137.NET_RX
>>      22846 =C2=B1  2%     +39.9%      31955        =
softirqs.CPU137.SCHED
>>      26519 =C2=B1  6%     +51.6%      40192 =C2=B1  4%  =
softirqs.CPU138.NET_RX
>>      22478 =C2=B1  2%     +41.7%      31858        =
softirqs.CPU138.SCHED
>>      26079 =C2=B1  9%     +62.0%      42258 =C2=B1  2%  =
softirqs.CPU139.NET_RX
>>      22994 =C2=B1  3%     +39.2%      32007        =
softirqs.CPU139.SCHED
>>      26936 =C2=B1  2%     +43.0%      38512 =C2=B1  9%  =
softirqs.CPU14.NET_RX
>>      22604 =C2=B1  3%     +42.3%      32166 =C2=B1  3%  =
softirqs.CPU14.SCHED
>>      27625 =C2=B1  9%     +44.2%      39847 =C2=B1  5%  =
softirqs.CPU140.NET_RX
>>      33066 =C2=B1  5%     +14.6%      37895 =C2=B1  8%  =
softirqs.CPU140.RCU
>>      22609           +41.6%      32006        softirqs.CPU140.SCHED
>>      26460 =C2=B1  5%     +58.1%      41826 =C2=B1  5%  =
softirqs.CPU141.NET_RX
>>      34319 =C2=B1  4%      +9.6%      37601 =C2=B1  8%  =
softirqs.CPU141.RCU
>>      22848 =C2=B1  2%     +39.5%      31868        =
softirqs.CPU141.SCHED
>>      27385 =C2=B1  8%     +52.1%      41645 =C2=B1  6%  =
softirqs.CPU142.NET_RX
>>      22881 =C2=B1  2%     +40.0%      32033        =
softirqs.CPU142.SCHED
>>      27724 =C2=B1  3%     +46.8%      40700 =C2=B1  5%  =
softirqs.CPU143.NET_RX
>>      34109 =C2=B1  4%     +10.8%      37789 =C2=B1  8%  =
softirqs.CPU143.RCU
>>      23092 =C2=B1  2%     +39.1%      32110        =
softirqs.CPU143.SCHED
>>      28902 =C2=B1  8%     +30.5%      37711        =
softirqs.CPU144.NET_RX
>>      34885 =C2=B1  7%      +8.2%      37745 =C2=B1  7%  =
softirqs.CPU144.RCU
>>      22671           +40.8%      31929        softirqs.CPU144.SCHED
>>      29181 =C2=B1 10%     +43.3%      41814 =C2=B1  7%  =
softirqs.CPU145.NET_RX
>>      22655           +38.5%      31371 =C2=B1  2%  =
softirqs.CPU145.SCHED
>>      28250 =C2=B1  7%     +33.9%      37815 =C2=B1  5%  =
softirqs.CPU146.NET_RX
>>      22502           +42.7%      32115        softirqs.CPU146.SCHED
>>      26352 =C2=B1  5%     +44.3%      38033 =C2=B1  4%  =
softirqs.CPU147.NET_RX
>>      34098            +9.1%      37212 =C2=B1  5%  =
softirqs.CPU147.RCU
>>      22712           +39.8%      31759        softirqs.CPU147.SCHED
>>      26457 =C2=B1  5%     +47.7%      39077 =C2=B1  2%  =
softirqs.CPU148.NET_RX
>>      34771           +10.8%      38542 =C2=B1  5%  =
softirqs.CPU148.RCU
>>      22626           +41.1%      31925        softirqs.CPU148.SCHED
>>      27813 =C2=B1  3%     +38.2%      38431 =C2=B1  3%  =
softirqs.CPU149.NET_RX
>>      34785 =C2=B1  3%      +9.4%      38071 =C2=B1  6%  =
softirqs.CPU149.RCU
>>      22830           +39.5%      31857        softirqs.CPU149.SCHED
>>      27674           +35.0%      37356 =C2=B1 10%  =
softirqs.CPU15.NET_RX
>>      22708 =C2=B1  3%     +40.8%      31984 =C2=B1  2%  =
softirqs.CPU15.SCHED
>>      28914 =C2=B1  4%     +38.6%      40073 =C2=B1  5%  =
softirqs.CPU150.NET_RX
>>      22867           +40.2%      32054        softirqs.CPU150.SCHED
>>      26654           +46.9%      39145 =C2=B1  4%  =
softirqs.CPU151.NET_RX
>>      35269 =C2=B1  5%      +7.1%      37772 =C2=B1  5%  =
softirqs.CPU151.RCU
>>      22567           +41.7%      31987        softirqs.CPU151.SCHED
>>      27340 =C2=B1  3%     +35.5%      37050 =C2=B1  7%  =
softirqs.CPU152.NET_RX
>>      22561           +41.1%      31833        softirqs.CPU152.SCHED
>>      25682 =C2=B1  4%     +52.9%      39264 =C2=B1  3%  =
softirqs.CPU153.NET_RX
>>      33854 =C2=B1  3%     +13.6%      38450 =C2=B1  5%  =
softirqs.CPU153.RCU
>>      22484           +42.2%      31972        softirqs.CPU153.SCHED
>>      27824 =C2=B1  6%     +45.0%      40343        =
softirqs.CPU154.NET_RX
>>      34996 =C2=B1  2%      +9.1%      38165 =C2=B1  5%  =
softirqs.CPU154.RCU
>>      22409           +41.5%      31717        softirqs.CPU154.SCHED
>>      26948 =C2=B1  6%     +51.9%      40940 =C2=B1  3%  =
softirqs.CPU155.NET_RX
>>      35069           +10.6%      38779 =C2=B1  5%  =
softirqs.CPU155.RCU
>>      22696           +42.2%      32266        softirqs.CPU155.SCHED
>>      26787 =C2=B1  3%     +45.7%      39032 =C2=B1  4%  =
softirqs.CPU156.NET_RX
>>      22583           +41.3%      31902        softirqs.CPU156.SCHED
>>      26065 =C2=B1  2%     +47.8%      38529 =C2=B1  4%  =
softirqs.CPU157.NET_RX
>>      22442           +42.0%      31866        softirqs.CPU157.SCHED
>>      27310 =C2=B1  3%     +42.2%      38826 =C2=B1  8%  =
softirqs.CPU158.NET_RX
>>      22593           +40.5%      31752        softirqs.CPU158.SCHED
>>      26411 =C2=B1  4%     +47.7%      39018        =
softirqs.CPU159.NET_RX
>>      22535           +42.5%      32103        softirqs.CPU159.SCHED
>>      28586 =C2=B1  3%     +30.9%      37421 =C2=B1  8%  =
softirqs.CPU16.NET_RX
>>      22668 =C2=B1  3%     +45.0%      32879 =C2=B1  3%  =
softirqs.CPU16.SCHED
>>      27341 =C2=B1  2%     +39.4%      38105 =C2=B1  2%  =
softirqs.CPU160.NET_RX
>>      22494           +41.5%      31829        softirqs.CPU160.SCHED
>>      26309           +47.7%      38870 =C2=B1  6%  =
softirqs.CPU161.NET_RX
>>      22652           +41.1%      31964        softirqs.CPU161.SCHED
>>      28102 =C2=B1  3%     +35.3%      38031 =C2=B1  3%  =
softirqs.CPU162.NET_RX
>>      34995 =C2=B1  4%      +6.5%      37255 =C2=B1  7%  =
softirqs.CPU162.RCU
>>      22800           +40.4%      32000        softirqs.CPU162.SCHED
>>      24958 =C2=B1  5%     +53.9%      38412 =C2=B1  7%  =
softirqs.CPU163.NET_RX
>>      22582           +42.1%      32079        softirqs.CPU163.SCHED
>>      27327 =C2=B1  2%     +36.9%      37415 =C2=B1  4%  =
softirqs.CPU164.NET_RX
>>      22516           +43.0%      32204        softirqs.CPU164.SCHED
>>      27456 =C2=B1  5%     +46.4%      40188 =C2=B1  4%  =
softirqs.CPU165.NET_RX
>>      22509           +42.6%      32104        softirqs.CPU165.SCHED
>>      26840 =C2=B1  3%     +42.0%      38118 =C2=B1  5%  =
softirqs.CPU166.NET_RX
>>      22847           +40.1%      32002        softirqs.CPU166.SCHED
>>      28288 =C2=B1  2%     +45.7%      41208 =C2=B1  8%  =
softirqs.CPU167.NET_RX
>>      22656           +43.6%      32529 =C2=B1  2%  =
softirqs.CPU167.SCHED
>>      27845           +40.0%      38982 =C2=B1  5%  =
softirqs.CPU168.NET_RX
>>      22861           +39.9%      31984        softirqs.CPU168.SCHED
>>      26590 =C2=B1  8%     +55.4%      41316 =C2=B1  5%  =
softirqs.CPU169.NET_RX
>>      22774           +40.5%      31990        softirqs.CPU169.SCHED
>>      27965 =C2=B1  4%     +34.4%      37581 =C2=B1  6%  =
softirqs.CPU17.NET_RX
>>      22416           +43.0%      32064 =C2=B1  3%  =
softirqs.CPU17.SCHED
>>      29095 =C2=B1  2%     +43.8%      41848 =C2=B1  4%  =
softirqs.CPU170.NET_RX
>>      22753           +41.9%      32295        softirqs.CPU170.SCHED
>>      25289           +56.3%      39538 =C2=B1  4%  =
softirqs.CPU171.NET_RX
>>      33179 =C2=B1  2%      +7.3%      35615 =C2=B1  7%  =
softirqs.CPU171.RCU
>>      22899           +40.5%      32171        softirqs.CPU171.SCHED
>>      25293 =C2=B1  3%     +60.0%      40480 =C2=B1  7%  =
softirqs.CPU172.NET_RX
>>      22584           +42.6%      32196        softirqs.CPU172.SCHED
>>      27200 =C2=B1  5%     +50.1%      40831 =C2=B1  4%  =
softirqs.CPU173.NET_RX
>>      22804           +41.1%      32183        softirqs.CPU173.SCHED
>>      27779 =C2=B1  3%     +49.3%      41464 =C2=B1  7%  =
softirqs.CPU174.NET_RX
>>      22569           +42.0%      32056        softirqs.CPU174.SCHED
>>      26980 =C2=B1  6%     +49.2%      40261 =C2=B1  5%  =
softirqs.CPU175.NET_RX
>>      22818           +41.2%      32220        softirqs.CPU175.SCHED
>>      27496 =C2=B1  6%     +48.8%      40909 =C2=B1  9%  =
softirqs.CPU176.NET_RX
>>      22818           +40.9%      32139        softirqs.CPU176.SCHED
>>      27197           +42.7%      38817 =C2=B1  8%  =
softirqs.CPU177.NET_RX
>>      22770           +40.4%      31976        softirqs.CPU177.SCHED
>>      27688 =C2=B1  2%     +45.6%      40318 =C2=B1  8%  =
softirqs.CPU178.NET_RX
>>      22820           +39.9%      31937        softirqs.CPU178.SCHED
>>      26078 =C2=B1  4%     +51.3%      39444 =C2=B1  5%  =
softirqs.CPU179.NET_RX
>>      22716           +40.5%      31912        softirqs.CPU179.SCHED
>>      27755 =C2=B1  2%     +41.2%      39191 =C2=B1  8%  =
softirqs.CPU18.NET_RX
>>      22621 =C2=B1  2%     +41.0%      31900        =
softirqs.CPU18.SCHED
>>      28019 =C2=B1  5%     +40.3%      39303 =C2=B1  9%  =
softirqs.CPU180.NET_RX
>>      22549           +41.3%      31869        softirqs.CPU180.SCHED
>>      27487 =C2=B1 10%     +46.9%      40381 =C2=B1  7%  =
softirqs.CPU181.NET_RX
>>      22776           +40.2%      31943        softirqs.CPU181.SCHED
>>      26432 =C2=B1  2%     +55.0%      40971 =C2=B1  7%  =
softirqs.CPU182.NET_RX
>>      22815           +40.7%      32105        softirqs.CPU182.SCHED
>>      27997 =C2=B1  4%     +46.5%      41010 =C2=B1  4%  =
softirqs.CPU183.NET_RX
>>      22875           +39.9%      32004        softirqs.CPU183.SCHED
>>      24478 =C2=B1 14%     +67.2%      40939 =C2=B1 10%  =
softirqs.CPU184.NET_RX
>>      22192 =C2=B1  3%     +45.0%      32177        =
softirqs.CPU184.SCHED
>>      27366           +40.4%      38417 =C2=B1  8%  =
softirqs.CPU185.NET_RX
>>      22879           +40.4%      32119        softirqs.CPU185.SCHED
>>      28955 =C2=B1  4%     +36.2%      39443 =C2=B1  6%  =
softirqs.CPU186.NET_RX
>>      22929           +39.2%      31913        softirqs.CPU186.SCHED
>>      26140 =C2=B1  5%     +50.3%      39290 =C2=B1  8%  =
softirqs.CPU187.NET_RX
>>      23163           +38.6%      32110        softirqs.CPU187.SCHED
>>      26199           +56.2%      40920 =C2=B1 11%  =
softirqs.CPU188.NET_RX
>>      22814           +41.5%      32276        softirqs.CPU188.SCHED
>>      27178 =C2=B1  5%     +49.7%      40699 =C2=B1  3%  =
softirqs.CPU189.NET_RX
>>      22673           +41.5%      32083        softirqs.CPU189.SCHED
>>      27438 =C2=B1  7%     +38.7%      38069 =C2=B1  5%  =
softirqs.CPU19.NET_RX
>>      22583 =C2=B1  3%     +42.0%      32066 =C2=B1  2%  =
softirqs.CPU19.SCHED
>>      26118 =C2=B1  9%     +42.6%      37257 =C2=B1  8%  =
softirqs.CPU190.NET_RX
>>      22621           +41.6%      32022        softirqs.CPU190.SCHED
>>      25609 =C2=B1  5%     +52.5%      39055 =C2=B1  9%  =
softirqs.CPU191.NET_RX
>>      22510           +40.5%      31618        softirqs.CPU191.SCHED
>>      28410 =C2=B1  5%     +34.1%      38091 =C2=B1  5%  =
softirqs.CPU2.NET_RX
>>      22190           +43.9%      31937 =C2=B1  2%  =
softirqs.CPU2.SCHED
>>      28923 =C2=B1 10%     +37.5%      39780 =C2=B1  9%  =
softirqs.CPU20.NET_RX
>>      22749 =C2=B1  4%     +41.2%      32113 =C2=B1  2%  =
softirqs.CPU20.SCHED
>>      27078 =C2=B1  3%     +38.2%      37429 =C2=B1  8%  =
softirqs.CPU21.NET_RX
>>      22477 =C2=B1  3%     +42.5%      32029 =C2=B1  2%  =
softirqs.CPU21.SCHED
>>      26006 =C2=B1  9%     +49.7%      38922 =C2=B1 11%  =
softirqs.CPU22.NET_RX
>>      22743 =C2=B1  3%     +41.2%      32108 =C2=B1  2%  =
softirqs.CPU22.SCHED
>>      28691 =C2=B1  2%     +39.6%      40046 =C2=B1  5%  =
softirqs.CPU23.NET_RX
>>      22668 =C2=B1  3%     +41.1%      31976 =C2=B1  2%  =
softirqs.CPU23.SCHED
>>      32698 =C2=B1  4%     +27.5%      41704 =C2=B1  3%  =
softirqs.CPU24.NET_RX
>>      23538           +34.9%      31764        softirqs.CPU24.SCHED
>>      27793           +44.1%      40038 =C2=B1  9%  =
softirqs.CPU25.NET_RX
>>      22892 =C2=B1  2%     +38.0%      31602        =
softirqs.CPU25.SCHED
>>      30671 =C2=B1  3%     +36.4%      41822 =C2=B1  7%  =
softirqs.CPU26.NET_RX
>>      23207 =C2=B1  2%     +36.8%      31744        =
softirqs.CPU26.SCHED
>>      26281 =C2=B1  6%     +57.6%      41417 =C2=B1  3%  =
softirqs.CPU27.NET_RX
>>      22758 =C2=B1  2%     +40.4%      31952        =
softirqs.CPU27.SCHED
>>      26713 =C2=B1  5%     +54.6%      41300 =C2=B1  4%  =
softirqs.CPU28.NET_RX
>>      33769 =C2=B1  2%     +11.3%      37593 =C2=B1  7%  =
softirqs.CPU28.RCU
>>      22857 =C2=B1  3%     +38.2%      31586        =
softirqs.CPU28.SCHED
>>      27219 =C2=B1  3%     +53.1%      41664 =C2=B1  8%  =
softirqs.CPU29.NET_RX
>>      22988 =C2=B1  3%     +38.2%      31775        =
softirqs.CPU29.SCHED
>>      26571 =C2=B1  5%     +51.2%      40171 =C2=B1  8%  =
softirqs.CPU3.NET_RX
>>      23000 =C2=B1  3%     +38.9%      31946 =C2=B1  3%  =
softirqs.CPU3.SCHED
>>      26856 =C2=B1  4%     +57.9%      42396 =C2=B1  2%  =
softirqs.CPU30.NET_RX
>>      22915 =C2=B1  3%     +38.0%      31629        =
softirqs.CPU30.SCHED
>>      28747 =C2=B1  6%     +42.3%      40898 =C2=B1  9%  =
softirqs.CPU31.NET_RX
>>      22863 =C2=B1  2%     +39.4%      31864        =
softirqs.CPU31.SCHED
>>      26418 =C2=B1  4%     +56.0%      41211 =C2=B1  4%  =
softirqs.CPU32.NET_RX
>>      22861 =C2=B1  3%     +38.3%      31613        =
softirqs.CPU32.SCHED
>>      27379 =C2=B1 13%     +52.0%      41619 =C2=B1  3%  =
softirqs.CPU33.NET_RX
>>      22743           +38.7%      31538        softirqs.CPU33.SCHED
>>      27331 =C2=B1  6%     +47.9%      40432 =C2=B1  7%  =
softirqs.CPU34.NET_RX
>>      23071 =C2=B1  2%     +37.5%      31730        =
softirqs.CPU34.SCHED
>>      27997 =C2=B1  9%     +49.7%      41922 =C2=B1  4%  =
softirqs.CPU35.NET_RX
>>      34868 =C2=B1  3%     +10.6%      38580 =C2=B1  7%  =
softirqs.CPU35.RCU
>>      23029 =C2=B1  3%     +37.4%      31635        =
softirqs.CPU35.SCHED
>>      26763 =C2=B1  4%     +59.4%      42657 =C2=B1  6%  =
softirqs.CPU36.NET_RX
>>      22829           +38.7%      31657        softirqs.CPU36.SCHED
>>      27252           +48.6%      40489 =C2=B1  3%  =
softirqs.CPU37.NET_RX
>>      22546 =C2=B1  2%     +40.2%      31603        =
softirqs.CPU37.SCHED
>>      26072 =C2=B1  9%     +67.4%      43643 =C2=B1  7%  =
softirqs.CPU38.NET_RX
>>      22711 =C2=B1  4%     +39.6%      31710        =
softirqs.CPU38.SCHED
>>      27579 =C2=B1  3%     +57.8%      43518 =C2=B1  5%  =
softirqs.CPU39.NET_RX
>>      22705 =C2=B1  2%     +39.2%      31596        =
softirqs.CPU39.SCHED
>>      28570 =C2=B1  3%     +30.7%      37345 =C2=B1  7%  =
softirqs.CPU4.NET_RX
>>      22763 =C2=B1  3%     +41.4%      32189 =C2=B1  3%  =
softirqs.CPU4.SCHED
>>      26544 =C2=B1  5%     +52.0%      40348 =C2=B1  5%  =
softirqs.CPU40.NET_RX
>>      22746 =C2=B1  3%     +39.5%      31726        =
softirqs.CPU40.SCHED
>>      28165 =C2=B1  5%     +47.1%      41432 =C2=B1  3%  =
softirqs.CPU41.NET_RX
>>      22791 =C2=B1  3%     +38.8%      31624        =
softirqs.CPU41.SCHED
>>      28718 =C2=B1  6%     +43.4%      41176 =C2=B1  8%  =
softirqs.CPU42.NET_RX
>>      22603           +39.3%      31493        softirqs.CPU42.SCHED
>>      27257 =C2=B1  4%     +54.4%      42085 =C2=B1  4%  =
softirqs.CPU43.NET_RX
>>      22763 =C2=B1  3%     +39.4%      31742        =
softirqs.CPU43.SCHED
>>      26604 =C2=B1  3%     +58.0%      42041 =C2=B1  5%  =
softirqs.CPU44.NET_RX
>>      33772 =C2=B1  5%     +13.2%      38218 =C2=B1  7%  =
softirqs.CPU44.RCU
>>      22764 =C2=B1  2%     +39.6%      31790        =
softirqs.CPU44.SCHED
>>      26786 =C2=B1  4%     +54.4%      41361 =C2=B1  6%  =
softirqs.CPU45.NET_RX
>>      34271 =C2=B1  3%     +10.2%      37764 =C2=B1  8%  =
softirqs.CPU45.RCU
>>      22813 =C2=B1  3%     +38.4%      31565        =
softirqs.CPU45.SCHED
>>      28082 =C2=B1  5%     +43.0%      40154 =C2=B1  7%  =
softirqs.CPU46.NET_RX
>>      34703 =C2=B1  4%      +9.0%      37818 =C2=B1  6%  =
softirqs.CPU46.RCU
>>      22800 =C2=B1  4%     +39.4%      31785        =
softirqs.CPU46.SCHED
>>      28229 =C2=B1  2%     +49.3%      42156 =C2=B1  6%  =
softirqs.CPU47.NET_RX
>>      35007 =C2=B1  3%      +9.5%      38323 =C2=B1  7%  =
softirqs.CPU47.RCU
>>      22878 =C2=B1  2%     +38.2%      31613        =
softirqs.CPU47.SCHED
>>      29087 =C2=B1  4%     +39.9%      40686 =C2=B1  3%  =
softirqs.CPU48.NET_RX
>>      22510           +40.5%      31621        softirqs.CPU48.SCHED
>>      27833 =C2=B1  5%     +47.3%      40991 =C2=B1  6%  =
softirqs.CPU49.NET_RX
>>      22119           +42.7%      31572        softirqs.CPU49.SCHED
>>      28242           +35.9%      38374 =C2=B1  6%  =
softirqs.CPU5.NET_RX
>>      22636 =C2=B1  3%     +42.1%      32161 =C2=B1  2%  =
softirqs.CPU5.SCHED
>>      28615 =C2=B1  4%     +37.2%      39250 =C2=B1  5%  =
softirqs.CPU50.NET_RX
>>      34409           +12.2%      38623 =C2=B1  5%  softirqs.CPU50.RCU
>>      22248           +41.5%      31482        softirqs.CPU50.SCHED
>>      28739 =C2=B1  5%     +40.6%      40405        =
softirqs.CPU51.NET_RX
>>      22458 =C2=B1  2%     +41.1%      31679        =
softirqs.CPU51.SCHED
>>      28428 =C2=B1  6%     +34.7%      38284        =
softirqs.CPU52.NET_RX
>>      22308           +41.7%      31601        softirqs.CPU52.SCHED
>>      29032 =C2=B1  6%     +33.6%      38786 =C2=B1  7%  =
softirqs.CPU53.NET_RX
>>      34502 =C2=B1  5%     +10.0%      37943 =C2=B1  8%  =
softirqs.CPU53.RCU
>>      22408           +40.7%      31526        softirqs.CPU53.SCHED
>>      27640 =C2=B1  7%     +42.5%      39380 =C2=B1  2%  =
softirqs.CPU54.NET_RX
>>      22473           +40.7%      31609        softirqs.CPU54.SCHED
>>      26943 =C2=B1  9%     +42.4%      38374 =C2=B1  4%  =
softirqs.CPU55.NET_RX
>>      22289 =C2=B1  2%     +42.7%      31800        =
softirqs.CPU55.SCHED
>>      27400 =C2=B1  4%     +40.2%      38409 =C2=B1  5%  =
softirqs.CPU56.NET_RX
>>      22354           +40.0%      31300        softirqs.CPU56.SCHED
>>      26999 =C2=B1  2%     +46.5%      39554 =C2=B1  6%  =
softirqs.CPU57.NET_RX
>>      34130 =C2=B1  3%     +12.9%      38546 =C2=B1  7%  =
softirqs.CPU57.RCU
>>      22383           +41.0%      31569        softirqs.CPU57.SCHED
>>      26684 =C2=B1  3%     +50.6%      40177 =C2=B1  3%  =
softirqs.CPU58.NET_RX
>>      34403 =C2=B1  3%     +11.9%      38510 =C2=B1  7%  =
softirqs.CPU58.RCU
>>      21983           +44.1%      31667        softirqs.CPU58.SCHED
>>      28353           +41.2%      40037 =C2=B1  5%  =
softirqs.CPU59.NET_RX
>>      22456           +40.7%      31589        softirqs.CPU59.SCHED
>>      27801 =C2=B1 10%     +34.5%      37398 =C2=B1  5%  =
softirqs.CPU6.NET_RX
>>      22604 =C2=B1  3%     +41.8%      32058 =C2=B1  2%  =
softirqs.CPU6.SCHED
>>      26348 =C2=B1  3%     +55.7%      41023        =
softirqs.CPU60.NET_RX
>>      22333           +41.1%      31517        softirqs.CPU60.SCHED
>>      27592 =C2=B1  8%     +43.0%      39449 =C2=B1  4%  =
softirqs.CPU61.NET_RX
>>      22340           +40.8%      31449        softirqs.CPU61.SCHED
>>      27991 =C2=B1  6%     +39.9%      39173 =C2=B1  6%  =
softirqs.CPU62.NET_RX
>>      22336           +41.0%      31505        softirqs.CPU62.SCHED
>>      27979 =C2=B1  6%     +42.4%      39848 =C2=B1  6%  =
softirqs.CPU63.NET_RX
>>      22455           +40.7%      31595        softirqs.CPU63.SCHED
>>      27343 =C2=B1  4%     +47.1%      40224 =C2=B1  7%  =
softirqs.CPU64.NET_RX
>>      22264           +42.4%      31709        softirqs.CPU64.SCHED
>>      30930 =C2=B1 12%     +24.7%      38565 =C2=B1  3%  =
softirqs.CPU65.NET_RX
>>      22563           +39.9%      31572        softirqs.CPU65.SCHED
>>      27228 =C2=B1  3%     +40.3%      38207 =C2=B1  5%  =
softirqs.CPU66.NET_RX
>>      33624 =C2=B1  2%     +10.9%      37300 =C2=B1  6%  =
softirqs.CPU66.RCU
>>      22263           +42.0%      31615        softirqs.CPU66.SCHED
>>      26629 =C2=B1  7%     +45.8%      38826 =C2=B1  3%  =
softirqs.CPU67.NET_RX
>>      22267           +42.1%      31644        softirqs.CPU67.SCHED
>>      27039 =C2=B1  7%     +46.4%      39598 =C2=B1  3%  =
softirqs.CPU68.NET_RX
>>      22376           +41.0%      31552        softirqs.CPU68.SCHED
>>      26835 =C2=B1  4%     +41.3%      37921 =C2=B1  4%  =
softirqs.CPU69.NET_RX
>>      22292           +42.2%      31695        softirqs.CPU69.SCHED
>>      28526 =C2=B1  9%     +36.6%      38980 =C2=B1  9%  =
softirqs.CPU7.NET_RX
>>      22556 =C2=B1  3%     +42.0%      32026 =C2=B1  3%  =
softirqs.CPU7.SCHED
>>      27716 =C2=B1  6%     +44.2%      39956 =C2=B1  5%  =
softirqs.CPU70.NET_RX
>>      22376           +40.4%      31421        softirqs.CPU70.SCHED
>>      25987 =C2=B1  2%     +54.0%      40017 =C2=B1  5%  =
softirqs.CPU71.NET_RX
>>      22256           +42.9%      31803        softirqs.CPU71.SCHED
>>      30271 =C2=B1  2%     +31.6%      39836 =C2=B1  8%  =
softirqs.CPU72.NET_RX
>>      22864           +39.9%      31988        softirqs.CPU72.SCHED
>>      28646 =C2=B1  7%     +40.8%      40326 =C2=B1  6%  =
softirqs.CPU73.NET_RX
>>      22434           +41.4%      31715        softirqs.CPU73.SCHED
>>      27673 =C2=B1  4%     +44.6%      40027 =C2=B1  5%  =
softirqs.CPU74.NET_RX
>>      22454           +41.1%      31688        softirqs.CPU74.SCHED
>>      26780 =C2=B1  5%     +50.1%      40207 =C2=B1  5%  =
softirqs.CPU75.NET_RX
>>      22613           +40.8%      31840        softirqs.CPU75.SCHED
>>      28051           +45.5%      40826 =C2=B1  5%  =
softirqs.CPU76.NET_RX
>>      22608           +41.0%      31879        softirqs.CPU76.SCHED
>>      26339 =C2=B1  5%     +49.7%      39425 =C2=B1 10%  =
softirqs.CPU77.NET_RX
>>      22329           +43.4%      32019        softirqs.CPU77.SCHED
>>      28822           +38.8%      40011 =C2=B1  6%  =
softirqs.CPU78.NET_RX
>>      22588           +41.2%      31903        softirqs.CPU78.SCHED
>>      26965 =C2=B1  4%     +50.8%      40656 =C2=B1  8%  =
softirqs.CPU79.NET_RX
>>      22337           +41.9%      31701        softirqs.CPU79.SCHED
>>      28854 =C2=B1  2%     +36.0%      39243 =C2=B1  7%  =
softirqs.CPU8.NET_RX
>>      33868 =C2=B1  2%      +8.2%      36644 =C2=B1  4%  =
softirqs.CPU8.RCU
>>      22572 =C2=B1  2%     +41.6%      31966 =C2=B1  3%  =
softirqs.CPU8.SCHED
>>      25294 =C2=B1  3%     +62.3%      41046 =C2=B1  9%  =
softirqs.CPU80.NET_RX
>>      22560           +41.6%      31949        softirqs.CPU80.SCHED
>>      27226 =C2=B1  6%     +44.2%      39272 =C2=B1  5%  =
softirqs.CPU81.NET_RX
>>      22433           +41.8%      31802        softirqs.CPU81.SCHED
>>      28179 =C2=B1  2%     +45.8%      41089 =C2=B1  6%  =
softirqs.CPU82.NET_RX
>>      22503           +41.1%      31742        softirqs.CPU82.SCHED
>>      25370 =C2=B1  6%     +65.5%      41993 =C2=B1  3%  =
softirqs.CPU83.NET_RX
>>      33224 =C2=B1  3%      +9.5%      36387 =C2=B1  5%  =
softirqs.CPU83.RCU
>>      22482           +43.4%      32239        softirqs.CPU83.SCHED
>>      29150 =C2=B1  4%     +41.9%      41357 =C2=B1  6%  =
softirqs.CPU84.NET_RX
>>      22540           +40.3%      31629        softirqs.CPU84.SCHED
>>      27566 =C2=B1  7%     +45.2%      40032 =C2=B1  6%  =
softirqs.CPU85.NET_RX
>>      22614           +40.5%      31779        softirqs.CPU85.SCHED
>>      26616 =C2=B1  3%     +48.0%      39392 =C2=B1  8%  =
softirqs.CPU86.NET_RX
>>      22503           +41.8%      31899        softirqs.CPU86.SCHED
>>      27217           +54.7%      42097 =C2=B1  4%  =
softirqs.CPU87.NET_RX
>>      32656           +11.1%      36286 =C2=B1  8%  softirqs.CPU87.RCU
>>      22383           +41.8%      31744        softirqs.CPU87.SCHED
>>      29444 =C2=B1  5%     +35.2%      39821 =C2=B1  6%  =
softirqs.CPU88.NET_RX
>>      22560 =C2=B1  2%     +41.3%      31887        =
softirqs.CPU88.SCHED
>>      26383 =C2=B1  3%     +49.4%      39403 =C2=B1  5%  =
softirqs.CPU89.NET_RX
>>      22647           +41.2%      31984        softirqs.CPU89.SCHED
>>      27413           +45.5%      39873 =C2=B1  3%  =
softirqs.CPU9.NET_RX
>>      22436 =C2=B1  3%     +43.3%      32154 =C2=B1  2%  =
softirqs.CPU9.SCHED
>>      28117 =C2=B1  4%     +39.1%      39110 =C2=B1  5%  =
softirqs.CPU90.NET_RX
>>      22524           +41.6%      31903        softirqs.CPU90.SCHED
>>      28805 =C2=B1  3%     +43.1%      41207 =C2=B1  2%  =
softirqs.CPU91.NET_RX
>>      22981           +38.0%      31714        softirqs.CPU91.SCHED
>>      27920 =C2=B1  9%     +46.1%      40778 =C2=B1  7%  =
softirqs.CPU92.NET_RX
>>      33255 =C2=B1  4%      +8.9%      36199 =C2=B1  7%  =
softirqs.CPU92.RCU
>>      22467           +42.2%      31955        softirqs.CPU92.SCHED
>>      26935 =C2=B1  5%     +49.3%      40211 =C2=B1  6%  =
softirqs.CPU93.NET_RX
>>      22407           +42.4%      31898        softirqs.CPU93.SCHED
>>      25585 =C2=B1  6%     +63.7%      41880 =C2=B1  5%  =
softirqs.CPU94.NET_RX
>>      33095 =C2=B1  4%     +10.4%      36528 =C2=B1  9%  =
softirqs.CPU94.RCU
>>      22417           +41.7%      31761        softirqs.CPU94.SCHED
>>      27659 =C2=B1  6%     +43.3%      39639 =C2=B1  6%  =
softirqs.CPU95.NET_RX
>>      21998           +42.6%      31361        softirqs.CPU95.SCHED
>>      26582 =C2=B1  2%     +43.4%      38128 =C2=B1  8%  =
softirqs.CPU96.NET_RX
>>      22170 =C2=B1  3%     +45.7%      32297        =
softirqs.CPU96.SCHED
>>      27522 =C2=B1  5%     +39.4%      38353 =C2=B1  9%  =
softirqs.CPU97.NET_RX
>>      22468 =C2=B1  3%     +43.4%      32209 =C2=B1  2%  =
softirqs.CPU97.SCHED
>>      27117 =C2=B1 12%     +39.8%      37902 =C2=B1 10%  =
softirqs.CPU98.NET_RX
>>      22600           +43.2%      32361 =C2=B1  2%  =
softirqs.CPU98.SCHED
>>      26557 =C2=B1  2%     +43.7%      38161 =C2=B1  7%  =
softirqs.CPU99.NET_RX
>>      23003           +41.6%      32565        softirqs.CPU99.SCHED
>>    5270210           +44.9%    7635912        softirqs.NET_RX
>>    4357512           +40.8%    6136169        softirqs.SCHED
>>      80.01           -80.0        0.00        =
perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spi=
n_lock.scan_positives.dcache_readdir.iterate_dir
>>      81.90           -68.9       13.02 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getd=
ents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>      81.91           -68.9       13.03 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
>>      81.90           -68.9       13.03 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_sysca=
ll_64.entry_SYSCALL_64_after_hwframe
>>      80.60           -68.8       11.80 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir=
.__x64_sys_getdents64.do_syscall_64
>>      80.30           -68.7       11.63 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_read=
dir.iterate_dir.__x64_sys_getdents64
>>      85.88           -51.1       34.79 =C2=B1 13%  =
perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame
>>      85.98           -50.8       35.15 =C2=B1 13%  =
perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>>       0.37 =C2=B1 70%      +0.4        0.80 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.=
entry_SYSCALL_64_after_hwframe.creat64
>>       0.37 =C2=B1 70%      +0.4        0.81 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.creat64
>>       0.37 =C2=B1 70%      +0.4        0.81 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.creat64
>>       0.39 =C2=B1 70%      +0.4        0.82 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
>>       0.39 =C2=B1 70%      +0.4        0.84 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.creat64
>>       0.37 =C2=B1 70%      +0.6        0.93 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.div_long
>>       0.00            +0.6        0.62 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__s=
oftirqentry_text_start.asm_call_sysvec_on_stack
>>       0.00            +0.6        0.62 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.__strcat_chk
>>       0.39 =C2=B1 70%      +0.7        1.04 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.add_int.add_int
>>       0.38 =C2=B1 70%      +0.7        1.04 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.add_long.add_long
>>       0.00            +0.7        0.68 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text=
_start.asm_call_sysvec_on_stack.do_softirq_own_stack
>>       0.00            +0.7        0.69 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.asm_ca=
ll_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
>>       0.00            +0.7        0.73 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user=
_addr_fault.exc_page_fault.asm_exc_page_fault
>>       0.00            +0.8        0.76 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec=
_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
>>       0.00            +0.8        0.76 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_s=
tack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interr=
upt
>>       0.00            +0.8        0.76 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_=
apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>>       0.36 =C2=B1 70%      +0.8        1.12 =C2=B1 11%  =
perf-profile.calltrace.cycles-pp.__strncat_chk
>>       0.00            +0.8        0.77 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_pa=
ge_fault.asm_exc_page_fault
>>       0.00            +0.8        0.77 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.=
asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>>       0.00            +0.8        0.79 =C2=B1 23%  =
perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.__vma_=
adjust.__split_vma.__do_munmap
>>       0.00            +0.8        0.81 =C2=B1 23%  =
perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.__vma_adjust.__=
split_vma.__do_munmap.mmap_region
>>       0.00            +0.8        0.81 =C2=B1 22%  =
perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.__vma_=
adjust.__split_vma.mprotect_fixup
>>       0.00            +0.8        0.82 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat=
.do_filp_open.do_sys_openat2
>>       0.00            +0.8        0.84 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.__vma_adjust.__=
split_vma.mprotect_fixup.do_mprotect_pkey
>>       0.00            +0.8        0.85 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc=
_page_fault
>>       0.00            +0.9        0.85 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.d=
o_sys_openat2.do_sys_open
>>       0.00            +0.9        0.86 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
>>       0.00            +0.9        0.86 =C2=B1 22%  =
perf-profile.calltrace.cycles-pp.__vma_adjust.__split_vma.__do_munmap.mmap=
_region.do_mmap
>>       0.18 =C2=B1141%      +0.9        1.04 =C2=B1 24%  =
perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.unlink=
_file_vma.free_pgtables.unmap_region
>>       0.17 =C2=B1141%      +0.9        1.03 =C2=B1 22%  =
perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.vma_li=
nk.mmap_region.do_mmap
>>       0.00            +0.9        0.88 =C2=B1 24%  =
perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.m=
mput.begin_new_exec
>>       0.00            +0.9        0.88 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.__split_vma.__do_munmap.mmap_region.do_mm=
ap.vm_mmap_pgoff
>>       0.18 =C2=B1141%      +0.9        1.07 =C2=B1 23%  =
perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlink_file_vma=
.free_pgtables.unmap_region.__do_munmap
>>       0.17 =C2=B1141%      +0.9        1.06 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.vma_link.mmap_r=
egion.do_mmap.vm_mmap_pgoff
>>       0.18 =C2=B1141%      +0.9        1.08 =C2=B1 23%  =
perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_regio=
n.__do_munmap.mmap_region
>>       0.19 =C2=B1141%      +0.9        1.09 =C2=B1 23%  =
perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.__do_munmap.mm=
ap_region.do_mmap
>>       0.19 =C2=B1141%      +0.9        1.12 =C2=B1 23%  =
perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.mmap_region.do_m=
map.vm_mmap_pgoff
>>       0.00            +0.9        0.93 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.asm_exc_page_fault
>>       0.17 =C2=B1141%      +0.9        1.10 =C2=B1 19%  =
perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.begin_new_e=
xec.load_elf_binary
>>       0.18 =C2=B1141%      +0.9        1.12 =C2=B1 20%  =
perf-profile.calltrace.cycles-pp.vma_link.mmap_region.do_mmap.vm_mmap_pgof=
f.ksys_mmap_pgoff
>>       0.00            +0.9        0.94 =C2=B1 19%  =
perf-profile.calltrace.cycles-pp.__vma_adjust.__split_vma.mprotect_fixup.d=
o_mprotect_pkey.__x64_sys_mprotect
>>       0.00            +1.0        0.98 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.__split_vma.mprotect_fixup.do_mprotect_pk=
ey.__x64_sys_mprotect.do_syscall_64
>>       0.00            +1.0        1.02 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys=
_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.20 =C2=B1141%      +1.0        1.22 =C2=B1 24%  =
perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.m=
mput.do_exit
>>       0.00            +1.0        1.03 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
>>       0.00            +1.0        1.03 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe
>>       0.39 =C2=B1 72%      +1.1        1.45 =C2=B1 11%  =
perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe
>>       0.39 =C2=B1 72%      +1.1        1.45 =C2=B1 11%  =
perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64=
.entry_SYSCALL_64_after_hwframe
>>       0.00            +1.1        1.06 =C2=B1 26%  =
perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.d_alloc_cursor=
.dcache_dir_open.do_dentry_open
>>       0.00            +1.1        1.06 =C2=B1 26%  =
perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin=
_lock.lockref_get.d_alloc_cursor.dcache_dir_open
>>       0.00            +1.1        1.06 =C2=B1 26%  =
perf-profile.calltrace.cycles-pp.lockref_get.d_alloc_cursor.dcache_dir_ope=
n.do_dentry_open.path_openat
>>       0.00            +1.1        1.06 =C2=B1 26%  =
perf-profile.calltrace.cycles-pp.dcache_dir_open.do_dentry_open.path_opena=
t.do_filp_open.do_sys_openat2
>>       0.00            +1.1        1.06 =C2=B1 26%  =
perf-profile.calltrace.cycles-pp.d_alloc_cursor.dcache_dir_open.do_dentry_=
open.path_openat.do_filp_open
>>       0.20 =C2=B1141%      +1.1        1.27 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_for=
k
>>       0.20 =C2=B1141%      +1.1        1.27 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.__libc_fork
>>       0.20 =C2=B1141%      +1.1        1.27 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.__libc_fork
>>       0.19 =C2=B1141%      +1.1        1.27 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64=
.entry_SYSCALL_64_after_hwframe.__libc_fork
>>       0.21 =C2=B1141%      +1.1        1.33 =C2=B1 22%  =
perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.do_exit.do_=
group_exit
>>       0.00            +1.1        1.12 =C2=B1 11%  =
perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin=
_lock.dcache_readdir.iterate_dir.__x64_sys_getdents64
>>       0.60 =C2=B1  6%      +1.1        1.73 =C2=B1 24%  =
perf-profile.calltrace.cycles-pp.exit_mmap.mmput.begin_new_exec.load_elf_b=
inary.exec_binprm
>>       0.20 =C2=B1141%      +1.1        1.33 =C2=B1 13%  =
perf-profile.calltrace.cycles-pp.__libc_fork
>>       0.60 =C2=B1  6%      +1.1        1.73 =C2=B1 24%  =
perf-profile.calltrace.cycles-pp.mmput.begin_new_exec.load_elf_binary.exec=
_binprm.bprm_execve
>>       0.17 =C2=B1141%      +1.1        1.32 =C2=B1 16%  =
perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_e=
nter_state.cpuidle_enter.do_idle.cpu_startup_entry
>>       0.00            +1.1        1.15 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cac=
he_free.rcu_do_batch.rcu_core
>>       0.62 =C2=B1  6%      +1.2        1.78 =C2=B1 23%  =
perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.exec_binpr=
m.bprm_execve.do_execveat_common
>>       0.00            +1.2        1.18 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_ap=
ic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
>>       0.80 =C2=B1 20%      +1.2        2.03 =C2=B1 22%  =
perf-profile.calltrace.cycles-pp.__do_munmap.mmap_region.do_mmap.vm_mmap_p=
goff.ksys_mmap_pgoff
>>       0.73 =C2=B1 17%      +1.2        1.98 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x=
64_sys_exit_group
>>       0.73 =C2=B1 17%      +1.2        1.98 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exi=
t_group.do_syscall_64
>>       0.00            +1.3        1.28 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.do_dentry_open=
.path_openat.do_filp_open
>>       0.00            +1.3        1.28 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin=
_lock.lockref_get.do_dentry_open.path_openat
>>       0.00            +1.3        1.29 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.path_openat.do=
_filp_open.do_sys_openat2
>>       0.00            +1.4        1.36 =C2=B1 39%  =
perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.dup_mm=
ap.dup_mm.copy_process
>>       0.81 =C2=B1 16%      +1.4        2.20 =C2=B1 13%  =
perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_grou=
p.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.81 =C2=B1 16%      +1.4        2.21 =C2=B1 13%  =
perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
>>       0.81 =C2=B1 16%      +1.4        2.21 =C2=B1 13%  =
perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_sys=
call_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +1.4        1.41 =C2=B1 38%  =
perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.dup_mmap.dup_mm=
.copy_process.kernel_clone
>>       0.00            +1.4        1.41 =C2=B1 17%  =
perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.rcu_do_b=
atch.rcu_core.__softirqentry_text_start
>>       0.18 =C2=B1141%      +1.7        1.92 =C2=B1 26%  =
perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.unlink=
_file_vma.free_pgtables.exit_mmap
>>       0.19 =C2=B1141%      +1.8        2.01 =C2=B1 25%  =
perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlink_file_vma=
.free_pgtables.exit_mmap.mmput
>>       0.83 =C2=B1  5%      +1.8        2.65 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.d=
o_execveat_common.__x64_sys_execve
>>       0.83 =C2=B1  4%      +1.8        2.67 =C2=B1 13%  =
perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_commo=
n.__x64_sys_execve.do_syscall_64
>>       0.36 =C2=B1141%      +2.0        2.32 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys=
_clone.do_syscall_64
>>       1.24 =C2=B1 20%      +2.0        3.23 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mm=
ap_pgoff.do_syscall_64
>>       1.25 =C2=B1 20%      +2.0        3.23 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_=
syscall_64.entry_SYSCALL_64_after_hwframe
>>       1.26 =C2=B1 20%      +2.0        3.25 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
>>       1.26 =C2=B1 20%      +2.0        3.25 =C2=B1 21%  =
perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_=
64.entry_SYSCALL_64_after_hwframe
>>       1.68 =C2=B1 14%      +2.0        3.72 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.string_rtns_1
>>       0.19 =C2=B1141%      +2.1        2.29 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone=
.__do_sys_clone
>>       0.39 =C2=B1141%      +2.2        2.58 =C2=B1 13%  =
perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.=
do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +2.6        2.62 =C2=B1  6%  =
perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.d=
o_sys_openat2.do_sys_open
>>       0.40 =C2=B1 70%      +3.1        3.52 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__s=
oftirqentry_text_start.run_ksoftirqd
>>       0.61 =C2=B1 11%      +3.2        3.79 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text=
_start.run_ksoftirqd.smpboot_thread_fn
>>       0.61 =C2=B1 11%      +3.2        3.79 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ks=
oftirqd.smpboot_thread_fn.kthread
>>       0.61 =C2=B1 11%      +3.2        3.79 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.s=
mpboot_thread_fn.kthread.ret_from_fork
>>       0.61 =C2=B1 11%      +3.2        3.79 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.r=
et_from_fork
>>       0.61 =C2=B1 12%      +3.2        3.82 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
>>       0.65 =C2=B1 11%      +3.2        3.88 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>>       0.65 =C2=B1 11%      +3.2        3.89 =C2=B1 15%  =
perf-profile.calltrace.cycles-pp.ret_from_fork
>>       0.22 =C2=B1141%      +4.1        4.27 =C2=B1 28%  =
perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
>>       0.22 =C2=B1141%      +4.1        4.28 =C2=B1 28%  =
perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
>>       3.30 =C2=B1 10%      +6.1        9.36 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_en=
ter.do_idle.cpu_startup_entry
>>       0.00            +6.2        6.21 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__leg=
itimize_path.unlazy_walk.complete_walk
>>       0.00            +6.2        6.22 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.un=
lazy_walk.complete_walk.path_openat
>>       0.00            +6.2        6.22 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.unlazy_walk.complete_walk.path_openat.do_=
filp_open.do_sys_openat2
>>       0.00            +6.2        6.22 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.complete_wa=
lk.path_openat.do_filp_open
>>       0.00            +6.2        6.22 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do=
_sys_openat2.do_sys_open
>>       0.00            +6.5        6.47 =C2=B1  7%  =
perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_put_or_lock.dput.s=
tep_into.path_openat
>>       0.00            +6.5        6.47 =C2=B1  7%  =
perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin=
_lock.lockref_put_or_lock.dput.step_into
>>       0.00            +6.5        6.47 =C2=B1  7%  =
perf-profile.calltrace.cycles-pp.dput.step_into.path_openat.do_filp_open.d=
o_open_execat
>>       0.00            +6.5        6.47 =C2=B1  7%  =
perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.step_into.path_o=
penat.do_filp_open
>>       0.00            +7.0        6.99 =C2=B1 19%  =
perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.__open64_nocancel
>>       0.00            +7.0        6.99 =C2=B1 19%  =
perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.=
entry_SYSCALL_64_after_hwframe.__open64_nocancel
>>       0.00            +7.0        6.99 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.__open64_nocancel
>>       0.00            +7.0        7.00 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_n=
ocancel
>>       0.00            +7.0        7.00 =C2=B1 18%  =
perf-profile.calltrace.cycles-pp.__open64_nocancel
>>       3.79 =C2=B1 10%      +7.0       10.82 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle=
.cpu_startup_entry.start_secondary
>>       3.86 =C2=B1  9%      +7.1       10.96 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.s=
tart_secondary.secondary_startup_64_no_verify
>>       4.17 =C2=B1  6%      +7.4       11.59 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary=
.secondary_startup_64_no_verify
>>       4.17 =C2=B1  6%      +7.4       11.59 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.seconda=
ry_startup_64_no_verify
>>       4.17 =C2=B1  6%      +7.4       11.59 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_v=
erify
>>       4.20 =C2=B1  6%      +7.4       11.63 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>>       0.00            +8.6        8.58 =C2=B1 38%  =
perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +8.6        8.59 =C2=B1 38%  =
perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
>>       0.00           +11.2       11.23 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin=
_lock.scan_positives.dcache_readdir.iterate_dir
>>       0.56 =C2=B1  7%     +11.4       11.95 =C2=B1  2%  =
perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.d=
o_sys_open.do_syscall_64
>>       0.56 =C2=B1  7%     +11.4       11.96 =C2=B1  2%  =
perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00           +24.2       24.23 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__leg=
itimize_path.unlazy_walk.pick_link
>>       0.00           +24.2       24.25 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.unlazy_walk.pick_link.step_into.path_open=
at.do_filp_open
>>       0.00           +24.2       24.25 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.pick_link.s=
tep_into.path_openat
>>       0.00           +24.2       24.25 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.un=
lazy_walk.pick_link.step_into
>>       0.00           +24.2       24.25 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.pick_link.step_into.path_openat.do_filp_o=
pen.do_open_execat
>>       1.02 =C2=B1  4%     +24.4       25.41 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe.execve
>>       1.02 =C2=B1  4%     +24.4       25.42 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
>>       1.02 =C2=B1  4%     +24.4       25.42 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.execve
>>       1.02 =C2=B1  4%     +24.4       25.42 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe.execve
>>       1.03 =C2=B1  4%     +24.4       25.43 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.execve
>>       0.00           +30.4       30.45 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin=
_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk
>>       0.00           +30.8       30.82 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_ope=
n_execat.bprm_execve
>>       0.00           +30.8       30.84 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.do_filp_open.do_open_execat.bprm_execve.d=
o_execveat_common.__x64_sys_execve
>>       0.00           +30.8       30.84 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_open_execat.b=
prm_execve.do_execveat_common
>>       0.00           +30.8       30.84 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.do_open_execat.bprm_execve.do_execveat_co=
mmon.__x64_sys_execve.do_syscall_64
>>       0.95 =C2=B1  4%     +32.8       33.76 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_=
execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>      82.33           -82.3        0.00        =
perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>      81.90           -68.9       13.02 =C2=B1  5%  =
perf-profile.children.cycles-pp.dcache_readdir
>>      81.91           -68.9       13.03 =C2=B1  5%  =
perf-profile.children.cycles-pp.__x64_sys_getdents64
>>      81.90           -68.9       13.03 =C2=B1  5%  =
perf-profile.children.cycles-pp.iterate_dir
>>      80.60           -68.8       11.80 =C2=B1  5%  =
perf-profile.children.cycles-pp.scan_positives
>>      82.71           -27.9       54.83 =C2=B1  2%  =
perf-profile.children.cycles-pp._raw_spin_lock
>>      89.05           -18.0       71.08        =
perf-profile.children.cycles-pp.do_syscall_64
>>      89.35           -17.5       71.82        =
perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>>       0.54 =C2=B1 22%      -0.2        0.32 =C2=B1 20%  =
perf-profile.children.cycles-pp.llseek
>>       0.62            -0.2        0.45 =C2=B1  9%  =
perf-profile.children.cycles-pp.ksys_lseek
>>       0.62            -0.2        0.45 =C2=B1  9%  =
perf-profile.children.cycles-pp.dcache_dir_lseek
>>       0.06 =C2=B1  8%      +0.0        0.09 =C2=B1 21%  =
perf-profile.children.cycles-pp.ktime_get_update_offsets_now
>>       0.06 =C2=B1 13%      +0.0        0.10 =C2=B1 15%  =
perf-profile.children.cycles-pp.update_load_avg
>>       0.16 =C2=B1  8%      +0.0        0.21 =C2=B1 17%  =
perf-profile.children.cycles-pp.ktime_get
>>       0.00            +0.1        0.05        =
perf-profile.children.cycles-pp.copy_page
>>       0.00            +0.1        0.05        =
perf-profile.children.cycles-pp.copy_string_kernel
>>       0.00            +0.1        0.05        =
perf-profile.children.cycles-pp.time
>>       0.00            +0.1        0.05        =
perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
>>       0.00            +0.1        0.05        =
perf-profile.children.cycles-pp.perf_iterate_sb
>>       0.00            +0.1        0.05        =
perf-profile.children.cycles-pp._raw_spin_trylock
>>       0.00            +0.1        0.05        =
perf-profile.children.cycles-pp.irqtime_account_irq
>>       0.00            +0.1        0.05        =
perf-profile.children.cycles-pp.unlock_page
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.common_file_perm
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.shift_arg_pages
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.__list_del_entry_valid
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.__check_object_size
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.compar1
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.lru_add_drain_cpu
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.do_faccessat
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.call_rcu
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.children.cycles-pp.rebalance_domains
>>       0.00            +0.1        0.05 =C2=B1  9%  =
perf-profile.children.cycles-pp.__pud_alloc
>>       0.00            +0.1        0.05 =C2=B1  9%  =
perf-profile.children.cycles-pp.do_task_dead
>>       0.00            +0.1        0.06 =C2=B1  9%  =
perf-profile.children.cycles-pp.new_sync_read
>>       0.00            +0.1        0.06 =C2=B1  9%  =
perf-profile.children.cycles-pp.ip_finish_output2
>>       0.00            +0.1        0.06 =C2=B1  9%  =
perf-profile.children.cycles-pp.sync_regs
>>       0.00            +0.1        0.06 =C2=B1  9%  =
perf-profile.children.cycles-pp.d_add
>>       0.00            +0.1        0.06 =C2=B1  9%  =
perf-profile.children.cycles-pp.lru_add_drain
>>       0.00            +0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp._cond_resched
>>       0.00            +0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp.cfree
>>       0.00            +0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp.update_rq_clock
>>       0.00            +0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp.pagevec_lru_move_fn
>>       0.00            +0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp.__rb_insert_augmented
>>       0.00            +0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp.kfree
>>       0.00            +0.1        0.06 =C2=B1  7%  =
perf-profile.children.cycles-pp.security_cred_free
>>       0.00            +0.1        0.06 =C2=B1 14%  =
perf-profile.children.cycles-pp.worker_thread
>>       0.00            +0.1        0.06 =C2=B1 11%  =
perf-profile.children.cycles-pp.read
>>       0.00            +0.1        0.06        =
perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
>>       0.00            +0.1        0.06        =
perf-profile.children.cycles-pp.__might_sleep
>>       0.00            +0.1        0.06        =
perf-profile.children.cycles-pp.simple_lookup
>>       0.00            +0.1        0.06        =
perf-profile.children.cycles-pp.create_elf_tables
>>       0.00            +0.1        0.06        =
perf-profile.children.cycles-pp.setup_arg_pages
>>       0.02 =C2=B1141%      +0.1        0.08 =C2=B1 54%  =
perf-profile.children.cycles-pp.irq_enter_rcu
>>       0.00            +0.1        0.06 =C2=B1  6%  =
perf-profile.children.cycles-pp.alloc_pages_vma
>>       0.00            +0.1        0.06 =C2=B1  6%  =
perf-profile.children.cycles-pp.page_add_file_rmap
>>       0.00            +0.1        0.06 =C2=B1 17%  =
perf-profile.children.cycles-pp.memcpy_erms
>>       0.00            +0.1        0.07 =C2=B1 17%  =
perf-profile.children.cycles-pp.do_linkat
>>       0.00            +0.1        0.07 =C2=B1 17%  =
perf-profile.children.cycles-pp.__x64_sys_link
>>       0.00            +0.1        0.07 =C2=B1  7%  =
perf-profile.children.cycles-pp.inode_permission
>>       0.00            +0.1        0.07 =C2=B1  7%  =
perf-profile.children.cycles-pp.ip_output
>>       0.00            +0.1        0.07 =C2=B1 23%  =
perf-profile.children.cycles-pp.tick_nohz_next_event
>>       0.05 =C2=B1 70%      +0.1        0.12 =C2=B1 10%  =
perf-profile.children.cycles-pp.__close
>>       0.00            +0.1        0.07 =C2=B1 12%  =
perf-profile.children.cycles-pp.try_charge
>>       0.00            +0.1        0.07 =C2=B1  6%  =
perf-profile.children.cycles-pp.do_truncate
>>       0.00            +0.1        0.07 =C2=B1 12%  =
perf-profile.children.cycles-pp.udp_sendmsg
>>       0.00            +0.1        0.07 =C2=B1 12%  =
perf-profile.children.cycles-pp.put_task_stack
>>       0.00            +0.1        0.07 =C2=B1 12%  =
perf-profile.children.cycles-pp.free_pages_and_swap_cache
>>       0.02 =C2=B1141%      +0.1        0.08 =C2=B1  5%  =
perf-profile.children.cycles-pp.unlink
>>       0.07 =C2=B1 12%      +0.1        0.14 =C2=B1 15%  =
perf-profile.children.cycles-pp.write
>>       0.06            +0.1        0.13        =
perf-profile.children.cycles-pp.wake_up_new_task
>>       0.06 =C2=B1 13%      +0.1        0.13 =C2=B1  5%  =
perf-profile.children.cycles-pp.__d_lookup_rcu
>>       0.00            +0.1        0.07 =C2=B1 10%  =
perf-profile.children.cycles-pp.uncharge_batch
>>       0.00            +0.1        0.07        =
perf-profile.children.cycles-pp.group_send_sig_info
>>       0.00            +0.1        0.07        =
perf-profile.children.cycles-pp.__get_user_pages
>>       0.00            +0.1        0.07        =
perf-profile.children.cycles-pp.strnlen_user
>>       0.00            +0.1        0.07        =
perf-profile.children.cycles-pp.security_task_kill
>>       0.00            +0.1        0.07        =
perf-profile.children.cycles-pp.apparmor_task_kill
>>       0.00            +0.1        0.07 =C2=B1 10%  =
perf-profile.children.cycles-pp.__pmd_alloc
>>       0.05 =C2=B1  8%      +0.1        0.12 =C2=B1  4%  =
perf-profile.children.cycles-pp.apparmor_file_open
>>       0.09 =C2=B1 24%      +0.1        0.16 =C2=B1  6%  =
perf-profile.children.cycles-pp.kill
>>       0.05            +0.1        0.12 =C2=B1  3%  =
perf-profile.children.cycles-pp.security_file_free
>>       0.05            +0.1        0.12 =C2=B1  3%  =
perf-profile.children.cycles-pp.apparmor_file_free_security
>>       0.00            +0.1        0.07 =C2=B1  5%  =
perf-profile.children.cycles-pp.__anon_vma_prepare
>>       0.00            +0.1        0.07 =C2=B1  5%  =
perf-profile.children.cycles-pp.find_vma
>>       0.00            +0.1        0.07 =C2=B1  5%  =
perf-profile.children.cycles-pp.get_arg_page
>>       0.00            +0.1        0.07 =C2=B1  5%  =
perf-profile.children.cycles-pp.__get_user_pages_remote
>>       0.00            +0.1        0.07 =C2=B1  5%  =
perf-profile.children.cycles-pp.mem_cgroup_charge
>>       0.00            +0.1        0.07 =C2=B1  5%  =
perf-profile.children.cycles-pp.try_to_wake_up
>>       0.00            +0.1        0.07 =C2=B1  5%  =
perf-profile.children.cycles-pp.rcu_sched_clock_irq
>>       0.00            +0.1        0.07 =C2=B1 22%  =
perf-profile.children.cycles-pp.file_free_rcu
>>       0.05 =C2=B1  8%      +0.1        0.13 =C2=B1  6%  =
perf-profile.children.cycles-pp.security_file_open
>>       0.05 =C2=B1  8%      +0.1        0.13 =C2=B1  3%  =
perf-profile.children.cycles-pp.getname_flags
>>       0.03 =C2=B1 70%      +0.1        0.11 =C2=B1  4%  =
perf-profile.children.cycles-pp.kill_pid_info
>>       0.07            +0.1        0.15 =C2=B1  3%  =
perf-profile.children.cycles-pp.native_irq_return_iret
>>       0.00            +0.1        0.08 =C2=B1  6%  =
perf-profile.children.cycles-pp.vfs_read
>>       0.00            +0.1        0.08 =C2=B1  6%  =
perf-profile.children.cycles-pp.__mod_memcg_state
>>       0.00            +0.1        0.08 =C2=B1  6%  =
perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
>>       0.03 =C2=B1 70%      +0.1        0.11        =
perf-profile.children.cycles-pp.kill_something_info
>>       0.00            +0.1        0.08 =C2=B1  5%  =
perf-profile.children.cycles-pp.ksys_read
>>       0.00            +0.1        0.08 =C2=B1 10%  =
perf-profile.children.cycles-pp.rcu_cblist_dequeue
>>       0.00            +0.1        0.08 =C2=B1  8%  =
perf-profile.children.cycles-pp.vma_interval_tree_remove
>>       0.04 =C2=B1 71%      +0.1        0.12 =C2=B1  3%  =
perf-profile.children.cycles-pp.__x64_sys_kill
>>       0.00            +0.1        0.08 =C2=B1 10%  =
perf-profile.children.cycles-pp.filldir64
>>       0.00            +0.1        0.08 =C2=B1 10%  =
perf-profile.children.cycles-pp.put_cred_rcu
>>       0.00            +0.1        0.08 =C2=B1 26%  =
perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>>       0.00            +0.1        0.08 =C2=B1 13%  =
perf-profile.children.cycles-pp.__slab_free
>>       0.02 =C2=B1141%      +0.1        0.10        =
perf-profile.children.cycles-pp.up_write
>>       0.05 =C2=B1  8%      +0.1        0.14 =C2=B1  3%  =
perf-profile.children.cycles-pp.copy_pte_range
>>       0.00            +0.1        0.08 =C2=B1  5%  =
perf-profile.children.cycles-pp.clear_page_erms
>>       0.06 =C2=B1  8%      +0.1        0.14 =C2=B1  5%  =
perf-profile.children.cycles-pp.down_write
>>       0.02 =C2=B1141%      +0.1        0.10 =C2=B1 10%  =
perf-profile.children.cycles-pp.malloc
>>       0.00            +0.1        0.09 =C2=B1  4%  =
perf-profile.children.cycles-pp.wait4
>>       0.00            +0.1        0.09 =C2=B1  4%  =
perf-profile.children.cycles-pp.down_read
>>       0.00            +0.1        0.09 =C2=B1  4%  =
perf-profile.children.cycles-pp.__get_free_pages
>>       0.00            +0.1        0.09 =C2=B1  4%  =
perf-profile.children.cycles-pp.__put_anon_vma
>>       0.00            +0.1        0.09 =C2=B1  4%  =
perf-profile.children.cycles-pp.arch_do_signal
>>       0.00            +0.1        0.09 =C2=B1  4%  =
perf-profile.children.cycles-pp.__dentry_kill
>>       0.02 =C2=B1141%      +0.1        0.11 =C2=B1  4%  =
perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>>       0.00            +0.1        0.09        =
perf-profile.children.cycles-pp.strncpy_from_user
>>       0.00            +0.1        0.09 =C2=B1  7%  =
perf-profile.children.cycles-pp.aa_get_task_label
>>       0.00            +0.1        0.09 =C2=B1  7%  =
perf-profile.children.cycles-pp.schedule_idle
>>       0.00            +0.1        0.09 =C2=B1 17%  =
perf-profile.children.cycles-pp.rwsem_wake
>>       0.02 =C2=B1141%      +0.1        0.11 =C2=B1  4%  =
perf-profile.children.cycles-pp.___might_sleep
>>       0.03 =C2=B1 70%      +0.1        0.12 =C2=B1  4%  =
perf-profile.children.cycles-pp.copy_strings
>>       0.09 =C2=B1 13%      +0.1        0.19 =C2=B1 14%  =
perf-profile.children.cycles-pp.update_cfs_group
>>       0.08 =C2=B1 10%      +0.1        0.17 =C2=B1 11%  =
perf-profile.children.cycles-pp.new_sync_write
>>       0.00            +0.1        0.09 =C2=B1  4%  =
perf-profile.children.cycles-pp.sched_exec
>>       0.02 =C2=B1141%      +0.1        0.11        =
perf-profile.children.cycles-pp.alloc_set_pte
>>       0.05 =C2=B1  8%      +0.1        0.15 =C2=B1  2%  =
perf-profile.children.cycles-pp.get_page_from_freelist
>>       0.00            +0.1        0.10 =C2=B1  5%  =
perf-profile.children.cycles-pp.prep_new_page
>>       0.00            +0.1        0.10 =C2=B1  9%  =
perf-profile.children.cycles-pp.__pte_alloc
>>       0.04 =C2=B1 71%      +0.1        0.13 =C2=B1  6%  =
perf-profile.children.cycles-pp.__mmap
>>       0.00            +0.1        0.10 =C2=B1  8%  =
perf-profile.children.cycles-pp.sock_sendmsg
>>       0.00            +0.1        0.10 =C2=B1  4%  =
perf-profile.children.cycles-pp.perf_event_mmap
>>       0.00            +0.1        0.10 =C2=B1  8%  =
perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
>>       0.00            +0.1        0.10 =C2=B1 45%  =
perf-profile.children.cycles-pp.dcache_dir_close
>>       0.00            +0.1        0.10 =C2=B1  7%  =
perf-profile.children.cycles-pp.sock_write_iter
>>       0.00            +0.1        0.10 =C2=B1  7%  =
perf-profile.children.cycles-pp.lockref_put_return
>>       0.09 =C2=B1 10%      +0.1        0.19 =C2=B1  9%  =
perf-profile.children.cycles-pp.ksys_write
>>       0.02 =C2=B1141%      +0.1        0.12 =C2=B1  3%  =
perf-profile.children.cycles-pp.apparmor_task_getsecid
>>       0.08 =C2=B1  5%      +0.1        0.19 =C2=B1  9%  =
perf-profile.children.cycles-pp.vfs_write
>>       0.00            +0.1        0.11 =C2=B1 10%  =
perf-profile.children.cycles-pp.do_unlinkat
>>       0.08 =C2=B1 10%      +0.1        0.19 =C2=B1  2%  =
perf-profile.children.cycles-pp.find_idlest_group
>>       0.00            +0.1        0.11 =C2=B1 33%  =
perf-profile.children.cycles-pp.__close_nocancel
>>       0.00            +0.1        0.11 =C2=B1  4%  =
perf-profile.children.cycles-pp.vm_area_alloc
>>       0.06 =C2=B1 16%      +0.1        0.16 =C2=B1  5%  =
perf-profile.children.cycles-pp.do_anonymous_page
>>       0.02 =C2=B1141%      +0.1        0.12 =C2=B1  4%  =
perf-profile.children.cycles-pp.security_task_getsecid
>>       0.08 =C2=B1 14%      +0.1        0.19 =C2=B1  6%  =
perf-profile.children.cycles-pp.__xstat64
>>       0.00            +0.1        0.11        =
perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>>       0.06 =C2=B1 16%      +0.1        0.17 =C2=B1  4%  =
perf-profile.children.cycles-pp.obj_cgroup_charge
>>       0.07            +0.1        0.18 =C2=B1  5%  =
perf-profile.children.cycles-pp.apparmor_file_alloc_security
>>       0.00            +0.1        0.11 =C2=B1  3%  =
perf-profile.children.cycles-pp.__clear_user
>>       0.20 =C2=B1 12%      +0.1        0.31 =C2=B1 15%  =
perf-profile.children.cycles-pp.task_tick_fair
>>       0.02 =C2=B1141%      +0.1        0.13 =C2=B1  5%  =
perf-profile.children.cycles-pp.find_busiest_group
>>       0.02 =C2=B1141%      +0.1        0.13 =C2=B1  5%  =
perf-profile.children.cycles-pp.update_sd_lb_stats
>>       0.00            +0.1        0.11 =C2=B1  4%  =
perf-profile.children.cycles-pp.ima_file_check
>>       0.08 =C2=B1 10%      +0.1        0.20 =C2=B1  4%  =
perf-profile.children.cycles-pp.vma_interval_tree_insert
>>       0.07 =C2=B1 14%      +0.1        0.18 =C2=B1  4%  =
perf-profile.children.cycles-pp.page_remove_rmap
>>       0.02 =C2=B1141%      +0.1        0.14 =C2=B1  3%  =
perf-profile.children.cycles-pp.wp_page_copy
>>       0.02 =C2=B1141%      +0.1        0.14 =C2=B1  6%  =
perf-profile.children.cycles-pp.pte_alloc_one
>>       0.03 =C2=B1 70%      +0.1        0.15 =C2=B1  2%  =
perf-profile.children.cycles-pp.schedule
>>       0.07 =C2=B1 11%      +0.1        0.19        =
perf-profile.children.cycles-pp._dl_addr
>>       0.00            +0.1        0.12 =C2=B1  8%  =
perf-profile.children.cycles-pp.finish_task_switch
>>       0.00            +0.1        0.12 =C2=B1 13%  =
perf-profile.children.cycles-pp.__put_task_struct
>>       0.08            +0.1        0.20 =C2=B1  5%  =
perf-profile.children.cycles-pp.security_file_alloc
>>       0.09 =C2=B1  9%      +0.1        0.21 =C2=B1  2%  =
perf-profile.children.cycles-pp.select_task_rq_fair
>>       0.04 =C2=B1 71%      +0.1        0.16 =C2=B1  5%  =
perf-profile.children.cycles-pp.load_balance
>>       0.05 =C2=B1  8%      +0.1        0.18 =C2=B1  4%  =
perf-profile.children.cycles-pp.vm_area_dup
>>       0.04 =C2=B1 71%      +0.1        0.17 =C2=B1  2%  =
perf-profile.children.cycles-pp.__d_alloc
>>       0.02 =C2=B1141%      +0.1        0.15 =C2=B1  7%  =
perf-profile.children.cycles-pp.do_wait
>>       0.02 =C2=B1141%      +0.1        0.15 =C2=B1  5%  =
perf-profile.children.cycles-pp.pick_next_task_fair
>>       0.06 =C2=B1 16%      +0.1        0.19 =C2=B1  3%  =
perf-profile.children.cycles-pp.anon_vma_clone
>>       0.02 =C2=B1141%      +0.1        0.15 =C2=B1  8%  =
perf-profile.children.cycles-pp.__do_sys_wait4
>>       0.02 =C2=B1141%      +0.1        0.15 =C2=B1  8%  =
perf-profile.children.cycles-pp.kernel_wait4
>>       0.05 =C2=B1  8%      +0.1        0.19 =C2=B1  2%  =
perf-profile.children.cycles-pp.__vm_munmap
>>       0.28 =C2=B1 13%      +0.1        0.42 =C2=B1 12%  =
perf-profile.children.cycles-pp.scheduler_tick
>>       0.00            +0.1        0.14 =C2=B1  3%  =
perf-profile.children.cycles-pp.cna_order_queue
>>       0.08 =C2=B1 12%      +0.1        0.22 =C2=B1  5%  =
perf-profile.children.cycles-pp.copy_page_range
>>       0.06 =C2=B1 19%      +0.1        0.21 =C2=B1  7%  =
perf-profile.children.cycles-pp.__memcg_kmem_charge_page
>>       0.00            +0.1        0.15 =C2=B1  5%  =
perf-profile.children.cycles-pp.newidle_balance
>>       0.05 =C2=B1  8%      +0.2        0.21 =C2=B1 19%  =
perf-profile.children.cycles-pp.__lock_parent
>>       0.08 =C2=B1 14%      +0.2        0.26 =C2=B1  4%  =
perf-profile.children.cycles-pp.rwsem_spin_on_owner
>>       0.09 =C2=B1 15%      +0.2        0.28 =C2=B1  4%  =
perf-profile.children.cycles-pp.release_pages
>>       0.09 =C2=B1 19%      +0.2        0.28 =C2=B1  5%  =
perf-profile.children.cycles-pp.page_counter_try_charge
>>       0.21 =C2=B1 21%      +0.2        0.41 =C2=B1 10%  =
perf-profile.children.cycles-pp.div_int
>>       0.39 =C2=B1 14%      +0.2        0.58 =C2=B1 10%  =
perf-profile.children.cycles-pp.update_process_times
>>       0.39 =C2=B1 14%      +0.2        0.59 =C2=B1 10%  =
perf-profile.children.cycles-pp.tick_sched_handle
>>       0.09 =C2=B1 20%      +0.2        0.29 =C2=B1  3%  =
perf-profile.children.cycles-pp.__memcg_kmem_charge
>>       0.08 =C2=B1 17%      +0.2        0.28 =C2=B1  3%  =
perf-profile.children.cycles-pp.anon_vma_fork
>>       0.16 =C2=B1 12%      +0.2        0.36 =C2=B1 10%  =
perf-profile.children.cycles-pp.mem_rtns_1
>>       0.25 =C2=B1 20%      +0.2        0.46 =C2=B1 10%  =
perf-profile.children.cycles-pp.div_short
>>       0.07 =C2=B1 25%      +0.2        0.28 =C2=B1  4%  =
perf-profile.children.cycles-pp.remove_vma
>>       0.43 =C2=B1 14%      +0.2        0.64 =C2=B1 10%  =
perf-profile.children.cycles-pp.tick_sched_timer
>>       0.14 =C2=B1  3%      +0.2        0.36 =C2=B1  5%  =
perf-profile.children.cycles-pp.setlocale
>>       0.09 =C2=B1  9%      +0.2        0.31        =
perf-profile.children.cycles-pp.__schedule
>>       0.11 =C2=B1 12%      +0.2        0.33 =C2=B1  4%  =
perf-profile.children.cycles-pp.tlb_flush_mmu
>>       0.11 =C2=B1 16%      +0.2        0.34 =C2=B1  5%  =
perf-profile.children.cycles-pp.tlb_finish_mmu
>>       0.10 =C2=B1  4%      +0.2        0.33 =C2=B1 11%  =
perf-profile.children.cycles-pp.__fput
>>       0.11 =C2=B1 11%      +0.2        0.35 =C2=B1  4%  =
perf-profile.children.cycles-pp.__alloc_pages_nodemask
>>       0.52 =C2=B1 14%      +0.2        0.76 =C2=B1 12%  =
perf-profile.children.cycles-pp.__hrtimer_run_queues
>>       0.22 =C2=B1 19%      +0.2        0.46 =C2=B1 11%  =
perf-profile.children.cycles-pp.add_short
>>       0.13 =C2=B1 10%      +0.3        0.38 =C2=B1  5%  =
perf-profile.children.cycles-pp.lookup_fast
>>       0.09 =C2=B1 15%      +0.3        0.35        =
perf-profile.children.cycles-pp.unlink_anon_vmas
>>       0.09 =C2=B1 19%      +0.3        0.34 =C2=B1  4%  =
perf-profile.children.cycles-pp.get_obj_cgroup_from_current
>>       0.12 =C2=B1  3%      +0.3        0.38 =C2=B1 10%  =
perf-profile.children.cycles-pp.task_work_run
>>       0.09 =C2=B1 20%      +0.3        0.35        =
perf-profile.children.cycles-pp.iterate_supers
>>       0.09 =C2=B1 20%      +0.3        0.36 =C2=B1  2%  =
perf-profile.children.cycles-pp.__x64_sys_sync
>>       0.09 =C2=B1 20%      +0.3        0.36 =C2=B1  2%  =
perf-profile.children.cycles-pp.ksys_sync
>>       0.12 =C2=B1 11%      +0.3        0.39 =C2=B1  2%  =
perf-profile.children.cycles-pp.d_alloc
>>       0.09 =C2=B1 20%      +0.3        0.36 =C2=B1  2%  =
perf-profile.children.cycles-pp.sync
>>       0.75 =C2=B1 12%      +0.3        1.03 =C2=B1 11%  =
perf-profile.children.cycles-pp.hrtimer_interrupt
>>       0.75 =C2=B1 12%      +0.3        1.04 =C2=B1 12%  =
perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>>       0.15 =C2=B1  3%      +0.3        0.45 =C2=B1  8%  =
perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>>       0.09 =C2=B1 20%      +0.3        0.39 =C2=B1  3%  =
perf-profile.children.cycles-pp.load_elf_interp
>>       0.19 =C2=B1 12%      +0.3        0.49 =C2=B1  3%  =
perf-profile.children.cycles-pp.zap_pte_range
>>       0.20 =C2=B1 11%      +0.3        0.51 =C2=B1  3%  =
perf-profile.children.cycles-pp.unmap_page_range
>>       0.52 =C2=B1 19%      +0.3        0.84 =C2=B1  3%  =
perf-profile.children.cycles-pp.creat64
>>       0.21 =C2=B1  8%      +0.3        0.54 =C2=B1  3%  =
perf-profile.children.cycles-pp.unmap_vmas
>>       0.09 =C2=B1 24%      +0.3        0.42 =C2=B1 11%  =
perf-profile.children.cycles-pp.propagate_protected_usage
>>       0.28 =C2=B1 14%      +0.3        0.62 =C2=B1 10%  =
perf-profile.children.cycles-pp.__strcat_chk
>>       0.25 =C2=B1  7%      +0.3        0.59 =C2=B1  4%  =
perf-profile.children.cycles-pp.path_lookupat
>>       0.25 =C2=B1  8%      +0.4        0.60 =C2=B1  4%  =
perf-profile.children.cycles-pp.filename_lookup
>>       0.26 =C2=B1  8%      +0.4        0.62 =C2=B1  4%  =
perf-profile.children.cycles-pp.__do_sys_newstat
>>       0.19 =C2=B1 11%      +0.4        0.56 =C2=B1  4%  =
perf-profile.children.cycles-pp.__alloc_file
>>       0.19 =C2=B1  9%      +0.4        0.56 =C2=B1  3%  =
perf-profile.children.cycles-pp.alloc_empty_file
>>       0.26 =C2=B1  8%      +0.4        0.63 =C2=B1  4%  =
perf-profile.children.cycles-pp.vfs_statx
>>       0.12 =C2=B1 15%      +0.4        0.49 =C2=B1  2%  =
perf-profile.children.cycles-pp.elf_map
>>       0.22 =C2=B1 11%      +0.4        0.60 =C2=B1  2%  =
perf-profile.children.cycles-pp.d_alloc_parallel
>>       0.29 =C2=B1  8%      +0.4        0.68 =C2=B1  3%  =
perf-profile.children.cycles-pp.filemap_map_pages
>>       0.24 =C2=B1  9%      +0.4        0.63 =C2=B1  2%  =
perf-profile.children.cycles-pp.__lookup_slow
>>       0.30 =C2=B1 32%      +0.4        0.73 =C2=B1 41%  =
perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>>       0.49 =C2=B1 20%      +0.4        0.93 =C2=B1 10%  =
perf-profile.children.cycles-pp.div_long
>>       0.32 =C2=B1 10%      +0.5        0.78 =C2=B1  3%  =
perf-profile.children.cycles-pp.do_fault
>>       0.52 =C2=B1 17%      +0.5        1.04 =C2=B1  9%  =
perf-profile.children.cycles-pp.add_int
>>       0.51 =C2=B1 18%      +0.5        1.04 =C2=B1  8%  =
perf-profile.children.cycles-pp.add_long
>>       0.50 =C2=B1 14%      +0.6        1.12 =C2=B1 11%  =
perf-profile.children.cycles-pp.__strncat_chk
>>       0.12 =C2=B1 14%      +0.6        0.74 =C2=B1 10%  =
perf-profile.children.cycles-pp.terminate_walk
>>       0.39 =C2=B1 19%      +0.6        1.02 =C2=B1 18%  =
perf-profile.children.cycles-pp.mprotect_fixup
>>       0.39 =C2=B1 18%      +0.6        1.03 =C2=B1 18%  =
perf-profile.children.cycles-pp.__x64_sys_mprotect
>>       0.39 =C2=B1 18%      +0.6        1.03 =C2=B1 18%  =
perf-profile.children.cycles-pp.do_mprotect_pkey
>>       0.21 =C2=B1 23%      +0.7        0.90 =C2=B1 13%  =
perf-profile.children.cycles-pp.__memcg_kmem_uncharge
>>       0.46 =C2=B1 21%      +0.7        1.20 =C2=B1 21%  =
perf-profile.children.cycles-pp.unmap_region
>>       0.30 =C2=B1 17%      +0.7        1.04 =C2=B1  3%  =
perf-profile.children.cycles-pp.kmem_cache_alloc
>>       0.48 =C2=B1  9%      +0.8        1.23 =C2=B1  3%  =
perf-profile.children.cycles-pp.__handle_mm_fault
>>       0.50 =C2=B1 10%      +0.8        1.30 =C2=B1  3%  =
perf-profile.children.cycles-pp.handle_mm_fault
>>       0.53 =C2=B1  9%      +0.8        1.37 =C2=B1  3%  =
perf-profile.children.cycles-pp.do_user_addr_fault
>>       0.47 =C2=B1  9%      +0.8        1.30 =C2=B1  2%  =
perf-profile.children.cycles-pp.link_path_walk
>>       0.54 =C2=B1  8%      +0.8        1.38 =C2=B1  3%  =
perf-profile.children.cycles-pp.exc_page_fault
>>       0.48 =C2=B1  9%      +0.9        1.33 =C2=B1  3%  =
perf-profile.children.cycles-pp.walk_component
>>       0.49 =C2=B1 18%      +0.9        1.34 =C2=B1 13%  =
perf-profile.children.cycles-pp.__libc_fork
>>       0.50 =C2=B1 20%      +0.9        1.41 =C2=B1 16%  =
perf-profile.children.cycles-pp.vma_link
>>       0.59 =C2=B1  4%      +0.9        1.51 =C2=B1  4%  =
perf-profile.children.cycles-pp.asm_exc_page_fault
>>       0.34 =C2=B1 22%      +1.1        1.43 =C2=B1 12%  =
perf-profile.children.cycles-pp.page_counter_cancel
>>       0.72 =C2=B1 19%      +1.2        1.88 =C2=B1 19%  =
perf-profile.children.cycles-pp.__vma_adjust
>>       0.36 =C2=B1 22%      +1.2        1.54 =C2=B1 12%  =
perf-profile.children.cycles-pp.page_counter_uncharge
>>       0.74 =C2=B1 19%      +1.2        1.94 =C2=B1 19%  =
perf-profile.children.cycles-pp.__split_vma
>>       0.37 =C2=B1 21%      +1.2        1.59 =C2=B1  5%  =
perf-profile.children.cycles-pp.irq_exit_rcu
>>       0.36 =C2=B1 22%      +1.2        1.59 =C2=B1  5%  =
perf-profile.children.cycles-pp.do_softirq_own_stack
>>       0.00            +1.2        1.23 =C2=B1 19%  =
perf-profile.children.cycles-pp.dcache_dir_open
>>       0.00            +1.2        1.23 =C2=B1 19%  =
perf-profile.children.cycles-pp.d_alloc_cursor
>>       0.69 =C2=B1 15%      +1.3        1.96 =C2=B1 14%  =
perf-profile.children.cycles-pp.begin_new_exec
>>       0.85 =C2=B1 20%      +1.4        2.21 =C2=B1 20%  =
perf-profile.children.cycles-pp.__do_munmap
>>       0.81 =C2=B1 16%      +1.4        2.22 =C2=B1 13%  =
perf-profile.children.cycles-pp.__x64_sys_exit_group
>>       0.81 =C2=B1 16%      +1.4        2.22 =C2=B1 13%  =
perf-profile.children.cycles-pp.do_group_exit
>>       0.81 =C2=B1 16%      +1.4        2.22 =C2=B1 13%  =
perf-profile.children.cycles-pp.do_exit
>>       1.09 =C2=B1 16%      +1.4        2.50 =C2=B1  8%  =
perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
>>       0.84 =C2=B1 20%      +1.4        2.29 =C2=B1 15%  =
perf-profile.children.cycles-pp.dup_mmap
>>       0.39 =C2=B1 20%      +1.5        1.84 =C2=B1 12%  =
perf-profile.children.cycles-pp.drain_obj_stock
>>       0.85 =C2=B1 20%      +1.5        2.32 =C2=B1 15%  =
perf-profile.children.cycles-pp.dup_mm
>>       1.18 =C2=B1 15%      +1.6        2.74 =C2=B1  8%  =
perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>>       0.94 =C2=B1 18%      +1.6        2.58 =C2=B1 13%  =
perf-profile.children.cycles-pp.copy_process
>>       1.29 =C2=B1 11%      +1.6        2.94 =C2=B1  7%  =
perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>>       1.00 =C2=B1 18%      +1.7        2.72 =C2=B1 13%  =
perf-profile.children.cycles-pp.__do_sys_clone
>>       1.00 =C2=B1 18%      +1.7        2.72 =C2=B1 13%  =
perf-profile.children.cycles-pp.kernel_clone
>>       0.47 =C2=B1 18%      +1.8        2.25 =C2=B1 12%  =
perf-profile.children.cycles-pp.refill_obj_stock
>>       0.92 =C2=B1 14%      +1.9        2.78 =C2=B1 10%  =
perf-profile.children.cycles-pp.load_elf_binary
>>       0.93 =C2=B1 14%      +1.9        2.79 =C2=B1 10%  =
perf-profile.children.cycles-pp.exec_binprm
>>       1.68 =C2=B1 14%      +2.1        3.74 =C2=B1 10%  =
perf-profile.children.cycles-pp.string_rtns_1
>>       1.30 =C2=B1 20%      +2.1        3.37 =C2=B1 20%  =
perf-profile.children.cycles-pp.ksys_mmap_pgoff
>>       1.35 =C2=B1 19%      +2.2        3.51 =C2=B1 24%  =
perf-profile.children.cycles-pp.unlink_file_vma
>>       1.36 =C2=B1 20%      +2.3        3.63 =C2=B1 18%  =
perf-profile.children.cycles-pp.mmap_region
>>       1.37 =C2=B1 20%      +2.3        3.67 =C2=B1 18%  =
perf-profile.children.cycles-pp.do_mmap
>>       1.39 =C2=B1 20%      +2.3        3.72 =C2=B1 18%  =
perf-profile.children.cycles-pp.vm_mmap_pgoff
>>       1.46 =C2=B1 19%      +2.5        3.92 =C2=B1 21%  =
perf-profile.children.cycles-pp.free_pgtables
>>       1.40 =C2=B1 16%      +2.5        3.88 =C2=B1 14%  =
perf-profile.children.cycles-pp.exit_mmap
>>       1.40 =C2=B1 16%      +2.5        3.89 =C2=B1 14%  =
perf-profile.children.cycles-pp.mmput
>>       0.00            +2.7        2.65 =C2=B1  9%  =
perf-profile.children.cycles-pp.lockref_get
>>       0.08 =C2=B1  5%      +2.7        2.80 =C2=B1  8%  =
perf-profile.children.cycles-pp.do_dentry_open
>>       0.61 =C2=B1 11%      +3.2        3.79 =C2=B1 15%  =
perf-profile.children.cycles-pp.run_ksoftirqd
>>       0.61 =C2=B1 12%      +3.2        3.82 =C2=B1 15%  =
perf-profile.children.cycles-pp.smpboot_thread_fn
>>       0.65 =C2=B1 11%      +3.2        3.88 =C2=B1 15%  =
perf-profile.children.cycles-pp.kthread
>>       0.66 =C2=B1 11%      +3.3        3.92 =C2=B1 15%  =
perf-profile.children.cycles-pp.ret_from_fork
>>       0.91 =C2=B1 14%      +4.3        5.25 =C2=B1 12%  =
perf-profile.children.cycles-pp.rcu_do_batch
>>       0.92 =C2=B1 13%      +4.3        5.25 =C2=B1 12%  =
perf-profile.children.cycles-pp.rcu_core
>>       0.97 =C2=B1 13%      +4.4        5.38 =C2=B1 12%  =
perf-profile.children.cycles-pp.__softirqentry_text_start
>>       0.99 =C2=B1 14%      +4.5        5.52 =C2=B1 10%  =
perf-profile.children.cycles-pp.kmem_cache_free
>>       3.02 =C2=B1 19%      +4.7        7.76 =C2=B1 23%  =
perf-profile.children.cycles-pp.osq_lock
>>       3.15 =C2=B1 19%      +5.0        8.16 =C2=B1 22%  =
perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>>       3.33 =C2=B1 10%      +6.1        9.38 =C2=B1 10%  =
perf-profile.children.cycles-pp.intel_idle
>>       0.00            +6.4        6.37 =C2=B1  2%  =
perf-profile.children.cycles-pp.complete_walk
>>       0.13 =C2=B1  3%      +7.1        7.19 =C2=B1 18%  =
perf-profile.children.cycles-pp.__open64_nocancel
>>       3.89 =C2=B1  9%      +7.1       10.99 =C2=B1  8%  =
perf-profile.children.cycles-pp.cpuidle_enter_state
>>       3.89 =C2=B1  9%      +7.1       11.00 =C2=B1  8%  =
perf-profile.children.cycles-pp.cpuidle_enter
>>       0.28 =C2=B1  3%      +7.2        7.48 =C2=B1  6%  =
perf-profile.children.cycles-pp.lockref_put_or_lock
>>       4.17 =C2=B1  6%      +7.4       11.59 =C2=B1  8%  =
perf-profile.children.cycles-pp.start_secondary
>>       4.20 =C2=B1  6%      +7.4       11.63 =C2=B1  8%  =
perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>>       4.20 =C2=B1  6%      +7.4       11.63 =C2=B1  8%  =
perf-profile.children.cycles-pp.cpu_startup_entry
>>       4.20 =C2=B1  6%      +7.4       11.63 =C2=B1  8%  =
perf-profile.children.cycles-pp.do_idle
>>       0.54 =C2=B1  4%      +7.5        8.04 =C2=B1  6%  =
perf-profile.children.cycles-pp.dput
>>       1.12 =C2=B1  2%     +11.1       12.26 =C2=B1  2%  =
perf-profile.children.cycles-pp.do_sys_open
>>       1.12 =C2=B1  2%     +11.1       12.25 =C2=B1  2%  =
perf-profile.children.cycles-pp.do_sys_openat2
>>       0.06 =C2=B1 14%     +24.2       24.28 =C2=B1  4%  =
perf-profile.children.cycles-pp.pick_link
>>       1.03 =C2=B1  4%     +24.4       25.43 =C2=B1  8%  =
perf-profile.children.cycles-pp.execve
>>       0.17 =C2=B1 10%     +30.8       30.92 =C2=B1  3%  =
perf-profile.children.cycles-pp.lockref_get_not_dead
>>       0.10 =C2=B1  8%     +30.8       30.87 =C2=B1  3%  =
perf-profile.children.cycles-pp.do_open_execat
>>       0.18 =C2=B1  9%     +30.8       30.95 =C2=B1  3%  =
perf-profile.children.cycles-pp.__legitimize_path
>>       0.18 =C2=B1 12%     +30.8       30.96 =C2=B1  3%  =
perf-profile.children.cycles-pp.unlazy_walk
>>       0.20 =C2=B1 10%     +31.0       31.15 =C2=B1  3%  =
perf-profile.children.cycles-pp.step_into
>>       1.05 =C2=B1 14%     +32.7       33.76 =C2=B1  3%  =
perf-profile.children.cycles-pp.bprm_execve
>>       1.14 =C2=B1 13%     +32.9       33.99 =C2=B1  3%  =
perf-profile.children.cycles-pp.do_execveat_common
>>       1.15 =C2=B1 13%     +32.9       34.01 =C2=B1  3%  =
perf-profile.children.cycles-pp.__x64_sys_execve
>>       1.16 =C2=B1  3%     +41.8       42.98 =C2=B1  2%  =
perf-profile.children.cycles-pp.path_openat
>>       1.17 =C2=B1  3%     +41.8       42.98 =C2=B1  2%  =
perf-profile.children.cycles-pp.do_filp_open
>>       0.00           +54.2       54.20 =C2=B1  2%  =
perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
>>      81.68           -81.7        0.00        =
perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>       0.05 =C2=B1  8%      +0.0        0.08 =C2=B1 21%  =
perf-profile.self.cycles-pp.ktime_get_update_offsets_now
>>       0.00            +0.1        0.05        =
perf-profile.self.cycles-pp.link_path_walk
>>       0.00            +0.1        0.05        =
perf-profile.self.cycles-pp.apparmor_task_getsecid
>>       0.00            +0.1        0.05        =
perf-profile.self.cycles-pp.page_add_file_rmap
>>       0.00            +0.1        0.05        =
perf-profile.self.cycles-pp.common_file_perm
>>       0.00            +0.1        0.05        =
perf-profile.self.cycles-pp.__list_del_entry_valid
>>       0.00            +0.1        0.05        =
perf-profile.self.cycles-pp.copy_page
>>       0.00            +0.1        0.05        =
perf-profile.self.cycles-pp._raw_spin_trylock
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.self.cycles-pp.__rb_insert_augmented
>>       0.00            +0.1        0.05 =C2=B1  8%  =
perf-profile.self.cycles-pp.compar1
>>       0.00            +0.1        0.06 =C2=B1  9%  =
perf-profile.self.cycles-pp.__might_sleep
>>       0.00            +0.1        0.06 =C2=B1  9%  =
perf-profile.self.cycles-pp.sync_regs
>>       0.00            +0.1        0.06 =C2=B1 14%  =
perf-profile.self.cycles-pp.__alloc_file
>>       0.00            +0.1        0.06 =C2=B1  7%  =
perf-profile.self.cycles-pp.kfree
>>       0.00            +0.1        0.06        =
perf-profile.self.cycles-pp.strnlen_user
>>       0.00            +0.1        0.06        =
perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
>>       0.00            +0.1        0.06 =C2=B1 11%  =
perf-profile.self.cycles-pp.memcpy_erms
>>       0.00            +0.1        0.06 =C2=B1  6%  =
perf-profile.self.cycles-pp.free_pages_and_swap_cache
>>       0.00            +0.1        0.07 =C2=B1  7%  =
perf-profile.self.cycles-pp.filldir64
>>       0.00            +0.1        0.07 =C2=B1  7%  =
perf-profile.self.cycles-pp.rcu_sched_clock_irq
>>       0.06 =C2=B1 16%      +0.1        0.12 =C2=B1  3%  =
perf-profile.self.cycles-pp.__d_lookup_rcu
>>       0.00            +0.1        0.07 =C2=B1  6%  =
perf-profile.self.cycles-pp.copy_pte_range
>>       0.00            +0.1        0.07 =C2=B1  6%  =
perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>>       0.00            +0.1        0.07 =C2=B1 19%  =
perf-profile.self.cycles-pp.file_free_rcu
>>       0.00            +0.1        0.07 =C2=B1 10%  =
perf-profile.self.cycles-pp.rwsem_down_write_slowpath
>>       0.05 =C2=B1  8%      +0.1        0.12 =C2=B1  4%  =
perf-profile.self.cycles-pp.apparmor_file_open
>>       0.05            +0.1        0.12 =C2=B1  3%  =
perf-profile.self.cycles-pp.apparmor_file_free_security
>>       0.00            +0.1        0.07 =C2=B1  5%  =
perf-profile.self.cycles-pp.vma_interval_tree_remove
>>       0.07            +0.1        0.15 =C2=B1  3%  =
perf-profile.self.cycles-pp.native_irq_return_iret
>>       0.00            +0.1        0.08 =C2=B1  6%  =
perf-profile.self.cycles-pp.__mod_memcg_state
>>       0.00            +0.1        0.08 =C2=B1 11%  =
perf-profile.self.cycles-pp.rcu_cblist_dequeue
>>       0.00            +0.1        0.08 =C2=B1 14%  =
perf-profile.self.cycles-pp.__handle_mm_fault
>>       0.00            +0.1        0.08 =C2=B1  5%  =
perf-profile.self.cycles-pp.down_read
>>       0.02 =C2=B1141%      +0.1        0.10 =C2=B1  5%  =
perf-profile.self.cycles-pp.up_write
>>       0.00            +0.1        0.08 =C2=B1 13%  =
perf-profile.self.cycles-pp.__slab_free
>>       0.06 =C2=B1  8%      +0.1        0.14 =C2=B1  8%  =
perf-profile.self.cycles-pp.lockref_get_not_dead
>>       0.00            +0.1        0.08 =C2=B1  5%  =
perf-profile.self.cycles-pp.clear_page_erms
>>       0.03 =C2=B1 70%      +0.1        0.12 =C2=B1  6%  =
perf-profile.self.cycles-pp.down_write
>>       0.00            +0.1        0.09 =C2=B1  7%  =
perf-profile.self.cycles-pp.malloc
>>       0.00            +0.1        0.09 =C2=B1  7%  =
perf-profile.self.cycles-pp.aa_get_task_label
>>       0.02 =C2=B1141%      +0.1        0.11 =C2=B1  4%  =
perf-profile.self.cycles-pp.___might_sleep
>>       0.09 =C2=B1 13%      +0.1        0.19 =C2=B1 14%  =
perf-profile.self.cycles-pp.update_cfs_group
>>       0.06 =C2=B1 13%      +0.1        0.15 =C2=B1  5%  =
perf-profile.self.cycles-pp.page_remove_rmap
>>       0.07 =C2=B1 11%      +0.1        0.17 =C2=B1  2%  =
perf-profile.self.cycles-pp.find_idlest_group
>>       0.00            +0.1        0.10 =C2=B1  4%  =
perf-profile.self.cycles-pp.lockref_put_return
>>       0.07 =C2=B1  7%      +0.1        0.17 =C2=B1  6%  =
perf-profile.self.cycles-pp.apparmor_file_alloc_security
>>       0.00            +0.1        0.11 =C2=B1  7%  =
perf-profile.self.cycles-pp.update_sd_lb_stats
>>       0.08 =C2=B1 10%      +0.1        0.19 =C2=B1  3%  =
perf-profile.self.cycles-pp.vma_interval_tree_insert
>>       0.04 =C2=B1 71%      +0.1        0.15 =C2=B1  5%  =
perf-profile.self.cycles-pp.release_pages
>>       0.00            +0.1        0.12 =C2=B1 13%  =
perf-profile.self.cycles-pp.page_counter_uncharge
>>       0.07 =C2=B1 11%      +0.1        0.19 =C2=B1  2%  =
perf-profile.self.cycles-pp._dl_addr
>>       0.00            +0.1        0.13 =C2=B1  3%  =
perf-profile.self.cycles-pp.cna_order_queue
>>       0.10 =C2=B1  8%      +0.1        0.25 =C2=B1  2%  =
perf-profile.self.cycles-pp.zap_pte_range
>>       0.08 =C2=B1 22%      +0.2        0.23 =C2=B1  4%  =
perf-profile.self.cycles-pp.page_counter_try_charge
>>       0.08 =C2=B1 14%      +0.2        0.25 =C2=B1  2%  =
perf-profile.self.cycles-pp.rwsem_spin_on_owner
>>       0.21 =C2=B1 20%      +0.2        0.40 =C2=B1 11%  =
perf-profile.self.cycles-pp.div_int
>>       0.15 =C2=B1  9%      +0.2        0.35 =C2=B1 11%  =
perf-profile.self.cycles-pp.mem_rtns_1
>>       0.25 =C2=B1 22%      +0.2        0.45 =C2=B1 11%  =
perf-profile.self.cycles-pp.div_short
>>       0.22 =C2=B1 19%      +0.2        0.45 =C2=B1 10%  =
perf-profile.self.cycles-pp.add_short
>>       0.08 =C2=B1 27%      +0.2        0.32 =C2=B1  4%  =
perf-profile.self.cycles-pp.get_obj_cgroup_from_current
>>       0.42 =C2=B1  2%      +0.3        0.69 =C2=B1  2%  =
perf-profile.self.cycles-pp._raw_spin_lock
>>       0.22 =C2=B1  9%      +0.3        0.49 =C2=B1  2%  =
perf-profile.self.cycles-pp.filemap_map_pages
>>       0.11 =C2=B1 19%      +0.3        0.41 =C2=B1  3%  =
perf-profile.self.cycles-pp.kmem_cache_alloc
>>       0.07 =C2=B1  6%      +0.3        0.40 =C2=B1 10%  =
perf-profile.self.cycles-pp.refill_obj_stock
>>       0.28 =C2=B1 14%      +0.3        0.60 =C2=B1 11%  =
perf-profile.self.cycles-pp.__strcat_chk
>>       0.09 =C2=B1 24%      +0.3        0.42 =C2=B1 11%  =
perf-profile.self.cycles-pp.propagate_protected_usage
>>       0.07 =C2=B1 11%      +0.4        0.46 =C2=B1 10%  =
perf-profile.self.cycles-pp.drain_obj_stock
>>       0.49 =C2=B1 19%      +0.4        0.92 =C2=B1 10%  =
perf-profile.self.cycles-pp.div_long
>>       0.51 =C2=B1 17%      +0.5        1.01 =C2=B1  8%  =
perf-profile.self.cycles-pp.add_long
>>       0.51 =C2=B1 17%      +0.5        1.02 =C2=B1  9%  =
perf-profile.self.cycles-pp.add_int
>>       0.49 =C2=B1 14%      +0.6        1.10 =C2=B1 11%  =
perf-profile.self.cycles-pp.__strncat_chk
>>       0.26 =C2=B1 21%      +0.8        1.04 =C2=B1 12%  =
perf-profile.self.cycles-pp.page_counter_cancel
>>       1.66 =C2=B1 14%      +2.0        3.65 =C2=B1 10%  =
perf-profile.self.cycles-pp.string_rtns_1
>>       0.49 =C2=B1 13%      +2.6        3.11 =C2=B1  9%  =
perf-profile.self.cycles-pp.kmem_cache_free
>>       2.93 =C2=B1 19%      +4.6        7.50 =C2=B1 22%  =
perf-profile.self.cycles-pp.osq_lock
>>       3.33 =C2=B1 10%      +6.0        9.38 =C2=B1 10%  =
perf-profile.self.cycles-pp.intel_idle
>>       0.00           +53.4       53.38 =C2=B1  2%  =
perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
>>       1579 =C2=B1 53%    +572.8%      10624 =C2=B1 82%  =
interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
>>       1203 =C2=B1112%     +61.3%       1940 =C2=B1 68%  =
interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1
>>       8340 =C2=B1 68%     -76.0%       2003 =C2=B1 74%  =
interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
>>     775419 =C2=B1  5%     +21.9%     944875 =C2=B1  2%  =
interrupts.CAL:Function_call_interrupts
>>       5146 =C2=B1  4%     -51.2%       2512 =C2=B1 34%  =
interrupts.CPU0.NMI:Non-maskable_interrupts
>>       5146 =C2=B1  4%     -51.2%       2512 =C2=B1 34%  =
interrupts.CPU0.PMI:Performance_monitoring_interrupts
>>       1113 =C2=B1  8%     +13.1%       1259 =C2=B1  4%  =
interrupts.CPU0.RES:Rescheduling_interrupts
>>     643.67 =C2=B1  4%     +53.6%     988.50 =C2=B1  7%  =
interrupts.CPU0.TLB:TLB_shootdowns
>>       4043 =C2=B1  7%     +33.6%       5400 =C2=B1  5%  =
interrupts.CPU1.CAL:Function_call_interrupts
>>       5177 =C2=B1  3%     -41.7%       3020 =C2=B1 36%  =
interrupts.CPU1.NMI:Non-maskable_interrupts
>>       5177 =C2=B1  3%     -41.7%       3020 =C2=B1 36%  =
interrupts.CPU1.PMI:Performance_monitoring_interrupts
>>     735.33 =C2=B1  5%     +48.3%       1090 =C2=B1  8%  =
interrupts.CPU1.RES:Rescheduling_interrupts
>>     562.00 =C2=B1 12%     +47.5%     829.00 =C2=B1  6%  =
interrupts.CPU1.TLB:TLB_shootdowns
>>       1579 =C2=B1 53%    +572.8%      10624 =C2=B1 82%  =
interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
>>       3821 =C2=B1  7%     +28.3%       4903 =C2=B1  6%  =
interrupts.CPU10.CAL:Function_call_interrupts
>>       5187 =C2=B1  4%     -23.5%       3968 =C2=B1  5%  =
interrupts.CPU10.NMI:Non-maskable_interrupts
>>       5187 =C2=B1  4%     -23.5%       3968 =C2=B1  5%  =
interrupts.CPU10.PMI:Performance_monitoring_interrupts
>>     738.67 =C2=B1  5%     +48.7%       1098 =C2=B1  4%  =
interrupts.CPU10.RES:Rescheduling_interrupts
>>     522.00 =C2=B1 33%     +72.4%     900.00 =C2=B1 10%  =
interrupts.CPU10.TLB:TLB_shootdowns
>>       3934 =C2=B1  9%     +24.9%       4913 =C2=B1  6%  =
interrupts.CPU100.CAL:Function_call_interrupts
>>       5204 =C2=B1  3%     -24.7%       3916 =C2=B1  8%  =
interrupts.CPU100.NMI:Non-maskable_interrupts
>>       5204 =C2=B1  3%     -24.7%       3916 =C2=B1  8%  =
interrupts.CPU100.PMI:Performance_monitoring_interrupts
>>     743.67 =C2=B1  7%     +61.4%       1200 =C2=B1  9%  =
interrupts.CPU100.RES:Rescheduling_interrupts
>>     474.00 =C2=B1 14%     +91.8%     909.00 =C2=B1 12%  =
interrupts.CPU100.TLB:TLB_shootdowns
>>       3945 =C2=B1  4%     +24.3%       4901 =C2=B1  4%  =
interrupts.CPU101.CAL:Function_call_interrupts
>>       5197 =C2=B1  3%     -36.2%       3313 =C2=B1 26%  =
interrupts.CPU101.NMI:Non-maskable_interrupts
>>       5197 =C2=B1  3%     -36.2%       3313 =C2=B1 26%  =
interrupts.CPU101.PMI:Performance_monitoring_interrupts
>>     720.33 =C2=B1  5%     +60.8%       1158 =C2=B1  7%  =
interrupts.CPU101.RES:Rescheduling_interrupts
>>     496.67 =C2=B1  7%     +82.6%     906.75 =C2=B1 15%  =
interrupts.CPU101.TLB:TLB_shootdowns
>>       3918 =C2=B1  5%     +22.8%       4810 =C2=B1  6%  =
interrupts.CPU102.CAL:Function_call_interrupts
>>       5186 =C2=B1  4%     -25.2%       3879 =C2=B1 10%  =
interrupts.CPU102.NMI:Non-maskable_interrupts
>>       5186 =C2=B1  4%     -25.2%       3879 =C2=B1 10%  =
interrupts.CPU102.PMI:Performance_monitoring_interrupts
>>     699.33 =C2=B1  3%     +61.8%       1131 =C2=B1  7%  =
interrupts.CPU102.RES:Rescheduling_interrupts
>>     406.33 =C2=B1  7%    +108.2%     846.00 =C2=B1 12%  =
interrupts.CPU102.TLB:TLB_shootdowns
>>       3882 =C2=B1  5%     +26.2%       4897 =C2=B1  4%  =
interrupts.CPU103.CAL:Function_call_interrupts
>>       5224 =C2=B1  3%     -34.9%       3399 =C2=B1 26%  =
interrupts.CPU103.NMI:Non-maskable_interrupts
>>       5224 =C2=B1  3%     -34.9%       3399 =C2=B1 26%  =
interrupts.CPU103.PMI:Performance_monitoring_interrupts
>>     658.33 =C2=B1  4%     +73.4%       1141 =C2=B1  5%  =
interrupts.CPU103.RES:Rescheduling_interrupts
>>     449.00 =C2=B1 16%     +89.6%     851.50 =C2=B1  8%  =
interrupts.CPU103.TLB:TLB_shootdowns
>>       3881 =C2=B1  3%     +23.9%       4807 =C2=B1  3%  =
interrupts.CPU104.CAL:Function_call_interrupts
>>       5212 =C2=B1  3%     -26.6%       3826 =C2=B1  8%  =
interrupts.CPU104.NMI:Non-maskable_interrupts
>>       5212 =C2=B1  3%     -26.6%       3826 =C2=B1  8%  =
interrupts.CPU104.PMI:Performance_monitoring_interrupts
>>     637.67 =C2=B1  7%     +73.6%       1106 =C2=B1  9%  =
interrupts.CPU104.RES:Rescheduling_interrupts
>>     423.33 =C2=B1  7%     +90.1%     804.75 =C2=B1 14%  =
interrupts.CPU104.TLB:TLB_shootdowns
>>       3845           +20.2%       4623        =
interrupts.CPU105.CAL:Function_call_interrupts
>>     661.33 =C2=B1  8%     +68.5%       1114 =C2=B1  2%  =
interrupts.CPU105.RES:Rescheduling_interrupts
>>     467.33 =C2=B1 17%     +87.6%     876.50 =C2=B1 21%  =
interrupts.CPU105.TLB:TLB_shootdowns
>>       3959 =C2=B1  4%     +18.2%       4679        =
interrupts.CPU106.CAL:Function_call_interrupts
>>       5251 =C2=B1  3%     -25.6%       3905 =C2=B1 10%  =
interrupts.CPU106.NMI:Non-maskable_interrupts
>>       5251 =C2=B1  3%     -25.6%       3905 =C2=B1 10%  =
interrupts.CPU106.PMI:Performance_monitoring_interrupts
>>     721.33 =C2=B1  5%     +59.2%       1148 =C2=B1  8%  =
interrupts.CPU106.RES:Rescheduling_interrupts
>>     419.00 =C2=B1 15%    +150.8%       1050 =C2=B1 30%  =
interrupts.CPU106.TLB:TLB_shootdowns
>>       3930 =C2=B1  5%     +18.9%       4674 =C2=B1  4%  =
interrupts.CPU107.CAL:Function_call_interrupts
>>       5177 =C2=B1  5%     -34.4%       3398 =C2=B1 26%  =
interrupts.CPU107.NMI:Non-maskable_interrupts
>>       5177 =C2=B1  5%     -34.4%       3398 =C2=B1 26%  =
interrupts.CPU107.PMI:Performance_monitoring_interrupts
>>     665.33 =C2=B1  5%     +75.8%       1169 =C2=B1  4%  =
interrupts.CPU107.RES:Rescheduling_interrupts
>>     445.00 =C2=B1 18%     +83.9%     818.50 =C2=B1 13%  =
interrupts.CPU107.TLB:TLB_shootdowns
>>       3915 =C2=B1  8%     +20.9%       4735 =C2=B1  3%  =
interrupts.CPU108.CAL:Function_call_interrupts
>>       5255 =C2=B1  3%     -36.2%       3350 =C2=B1 25%  =
interrupts.CPU108.NMI:Non-maskable_interrupts
>>       5255 =C2=B1  3%     -36.2%       3350 =C2=B1 25%  =
interrupts.CPU108.PMI:Performance_monitoring_interrupts
>>     684.33 =C2=B1  7%     +67.5%       1146 =C2=B1  7%  =
interrupts.CPU108.RES:Rescheduling_interrupts
>>     509.00 =C2=B1 11%     +66.4%     846.75 =C2=B1  6%  =
interrupts.CPU108.TLB:TLB_shootdowns
>>       3965 =C2=B1  3%     +19.8%       4749 =C2=B1  4%  =
interrupts.CPU109.CAL:Function_call_interrupts
>>       5207 =C2=B1  3%     -42.8%       2976 =C2=B1 38%  =
interrupts.CPU109.NMI:Non-maskable_interrupts
>>       5207 =C2=B1  3%     -42.8%       2976 =C2=B1 38%  =
interrupts.CPU109.PMI:Performance_monitoring_interrupts
>>     701.00 =C2=B1  4%     +55.2%       1087 =C2=B1  5%  =
interrupts.CPU109.RES:Rescheduling_interrupts
>>     510.33 =C2=B1 11%     +71.9%     877.25 =C2=B1  6%  =
interrupts.CPU109.TLB:TLB_shootdowns
>>       1203 =C2=B1112%     +61.3%       1940 =C2=B1 68%  =
interrupts.CPU11.32:PCI-MSI.524290-edge.eth0-TxRx-1
>>       3794 =C2=B1  5%     +31.8%       4999 =C2=B1  4%  =
interrupts.CPU11.CAL:Function_call_interrupts
>>     734.33 =C2=B1  6%     +51.7%       1114 =C2=B1  3%  =
interrupts.CPU11.RES:Rescheduling_interrupts
>>     458.67 =C2=B1 14%    +100.9%     921.50 =C2=B1 10%  =
interrupts.CPU11.TLB:TLB_shootdowns
>>       3949 =C2=B1  5%     +27.3%       5029 =C2=B1  4%  =
interrupts.CPU110.CAL:Function_call_interrupts
>>       5230 =C2=B1  3%     -35.3%       3385 =C2=B1 24%  =
interrupts.CPU110.NMI:Non-maskable_interrupts
>>       5230 =C2=B1  3%     -35.3%       3385 =C2=B1 24%  =
interrupts.CPU110.PMI:Performance_monitoring_interrupts
>>     670.67 =C2=B1  6%     +74.5%       1170 =C2=B1  7%  =
interrupts.CPU110.RES:Rescheduling_interrupts
>>     442.00 =C2=B1  8%     +88.5%     833.00 =C2=B1 18%  =
interrupts.CPU110.TLB:TLB_shootdowns
>>       3865 =C2=B1  4%     +24.2%       4802 =C2=B1  4%  =
interrupts.CPU111.CAL:Function_call_interrupts
>>       5230 =C2=B1  3%     -36.3%       3330 =C2=B1 25%  =
interrupts.CPU111.NMI:Non-maskable_interrupts
>>       5230 =C2=B1  3%     -36.3%       3330 =C2=B1 25%  =
interrupts.CPU111.PMI:Performance_monitoring_interrupts
>>     634.00 =C2=B1  9%     +85.7%       1177 =C2=B1 10%  =
interrupts.CPU111.RES:Rescheduling_interrupts
>>     441.33 =C2=B1 13%     +96.4%     866.75 =C2=B1 14%  =
interrupts.CPU111.TLB:TLB_shootdowns
>>       3873 =C2=B1  5%     +24.7%       4829 =C2=B1  2%  =
interrupts.CPU112.CAL:Function_call_interrupts
>>       5121 =C2=B1  4%     -35.0%       3326 =C2=B1 24%  =
interrupts.CPU112.NMI:Non-maskable_interrupts
>>       5121 =C2=B1  4%     -35.0%       3326 =C2=B1 24%  =
interrupts.CPU112.PMI:Performance_monitoring_interrupts
>>     669.00 =C2=B1  2%     +72.3%       1152 =C2=B1  7%  =
interrupts.CPU112.RES:Rescheduling_interrupts
>>     430.00 =C2=B1  2%    +111.9%     911.00 =C2=B1 15%  =
interrupts.CPU112.TLB:TLB_shootdowns
>>       3921 =C2=B1  6%     +24.6%       4885 =C2=B1  3%  =
interrupts.CPU113.CAL:Function_call_interrupts
>>     672.33 =C2=B1  8%     +70.0%       1142 =C2=B1  7%  =
interrupts.CPU113.RES:Rescheduling_interrupts
>>     431.33 =C2=B1  9%     +98.2%     855.00 =C2=B1 11%  =
interrupts.CPU113.TLB:TLB_shootdowns
>>       3779 =C2=B1  7%     +27.7%       4827 =C2=B1  4%  =
interrupts.CPU114.CAL:Function_call_interrupts
>>     641.00 =C2=B1 13%     +79.3%       1149 =C2=B1  4%  =
interrupts.CPU114.RES:Rescheduling_interrupts
>>     504.00 =C2=B1 10%     +77.2%     893.25 =C2=B1 20%  =
interrupts.CPU114.TLB:TLB_shootdowns
>>       3904 =C2=B1  6%     +20.2%       4693        =
interrupts.CPU115.CAL:Function_call_interrupts
>>     651.67 =C2=B1  3%     +78.9%       1165 =C2=B1  2%  =
interrupts.CPU115.RES:Rescheduling_interrupts
>>     501.67 =C2=B1 29%     +69.9%     852.50 =C2=B1  4%  =
interrupts.CPU115.TLB:TLB_shootdowns
>>       3818 =C2=B1  3%     +23.2%       4703        =
interrupts.CPU116.CAL:Function_call_interrupts
>>     630.67 =C2=B1  7%     +81.6%       1145 =C2=B1  6%  =
interrupts.CPU116.RES:Rescheduling_interrupts
>>     439.67 =C2=B1 14%     +98.7%     873.50 =C2=B1 15%  =
interrupts.CPU116.TLB:TLB_shootdowns
>>       4154 =C2=B1  4%     +13.8%       4728        =
interrupts.CPU117.CAL:Function_call_interrupts
>>     650.67 =C2=B1  8%     +70.7%       1110 =C2=B1  6%  =
interrupts.CPU117.RES:Rescheduling_interrupts
>>     502.33 =C2=B1 12%     +77.0%     889.00 =C2=B1 10%  =
interrupts.CPU117.TLB:TLB_shootdowns
>>       3947 =C2=B1  5%     +21.6%       4798 =C2=B1  5%  =
interrupts.CPU118.CAL:Function_call_interrupts
>>     659.33           +71.4%       1130 =C2=B1  4%  =
interrupts.CPU118.RES:Rescheduling_interrupts
>>     464.67 =C2=B1 11%     +84.5%     857.25 =C2=B1  9%  =
interrupts.CPU118.TLB:TLB_shootdowns
>>       4065 =C2=B1  4%     +19.6%       4860 =C2=B1  5%  =
interrupts.CPU119.CAL:Function_call_interrupts
>>     614.00 =C2=B1  8%     +82.9%       1123 =C2=B1  4%  =
interrupts.CPU119.RES:Rescheduling_interrupts
>>     480.33 =C2=B1  8%     +74.6%     838.50 =C2=B1  8%  =
interrupts.CPU119.TLB:TLB_shootdowns
>>       4011 =C2=B1  3%     +20.9%       4848 =C2=B1  7%  =
interrupts.CPU12.CAL:Function_call_interrupts
>>     769.33 =C2=B1  2%     +44.1%       1108 =C2=B1  8%  =
interrupts.CPU12.RES:Rescheduling_interrupts
>>     502.00 =C2=B1  4%     +96.4%     986.00 =C2=B1 12%  =
interrupts.CPU12.TLB:TLB_shootdowns
>>       4091 =C2=B1  4%     +22.3%       5003 =C2=B1  3%  =
interrupts.CPU120.CAL:Function_call_interrupts
>>     717.33 =C2=B1  9%     +64.2%       1177 =C2=B1  6%  =
interrupts.CPU120.RES:Rescheduling_interrupts
>>     459.67 =C2=B1 14%    +103.1%     933.50 =C2=B1 15%  =
interrupts.CPU120.TLB:TLB_shootdowns
>>       3923 =C2=B1  4%     +25.2%       4913 =C2=B1  3%  =
interrupts.CPU121.CAL:Function_call_interrupts
>>     617.33 =C2=B1  3%     +89.4%       1169 =C2=B1  4%  =
interrupts.CPU121.RES:Rescheduling_interrupts
>>     401.67 =C2=B1 22%    +195.5%       1186 =C2=B1 39%  =
interrupts.CPU121.TLB:TLB_shootdowns
>>       3867 =C2=B1  4%     +34.9%       5218 =C2=B1  4%  =
interrupts.CPU122.CAL:Function_call_interrupts
>>     596.67 =C2=B1  8%    +100.9%       1198 =C2=B1  5%  =
interrupts.CPU122.RES:Rescheduling_interrupts
>>     450.00 =C2=B1 16%    +109.0%     940.50 =C2=B1  6%  =
interrupts.CPU122.TLB:TLB_shootdowns
>>       4031 =C2=B1  8%     +23.2%       4967 =C2=B1  3%  =
interrupts.CPU123.CAL:Function_call_interrupts
>>     628.00 =C2=B1  4%     +94.1%       1218 =C2=B1  7%  =
interrupts.CPU123.RES:Rescheduling_interrupts
>>     474.67 =C2=B1 13%     +96.1%     931.00 =C2=B1 12%  =
interrupts.CPU123.TLB:TLB_shootdowns
>>       4232 =C2=B1  4%     +20.3%       5090 =C2=B1  3%  =
interrupts.CPU124.CAL:Function_call_interrupts
>>     639.00           +82.9%       1168 =C2=B1  7%  =
interrupts.CPU124.RES:Rescheduling_interrupts
>>     463.33 =C2=B1 17%    +110.1%     973.25 =C2=B1 11%  =
interrupts.CPU124.TLB:TLB_shootdowns
>>       3972           +21.5%       4826 =C2=B1  3%  =
interrupts.CPU125.CAL:Function_call_interrupts
>>     658.67 =C2=B1  8%     +78.4%       1175 =C2=B1  4%  =
interrupts.CPU125.RES:Rescheduling_interrupts
>>     480.00 =C2=B1 13%     +96.0%     940.75 =C2=B1 23%  =
interrupts.CPU125.TLB:TLB_shootdowns
>>       4093 =C2=B1  3%     +20.8%       4947 =C2=B1  4%  =
interrupts.CPU126.CAL:Function_call_interrupts
>>     672.67 =C2=B1  5%     +75.9%       1183 =C2=B1  2%  =
interrupts.CPU126.RES:Rescheduling_interrupts
>>     498.00 =C2=B1 10%     +90.0%     946.25 =C2=B1 11%  =
interrupts.CPU126.TLB:TLB_shootdowns
>>       4111 =C2=B1  5%     +20.8%       4965 =C2=B1  5%  =
interrupts.CPU127.CAL:Function_call_interrupts
>>     613.67 =C2=B1  2%     +95.2%       1198 =C2=B1  5%  =
interrupts.CPU127.RES:Rescheduling_interrupts
>>     451.67 =C2=B1 21%    +109.8%     947.50 =C2=B1 14%  =
interrupts.CPU127.TLB:TLB_shootdowns
>>       4066           +20.3%       4891 =C2=B1  3%  =
interrupts.CPU128.CAL:Function_call_interrupts
>>       5200 =C2=B1  2%     -23.3%       3986 =C2=B1  9%  =
interrupts.CPU128.NMI:Non-maskable_interrupts
>>       5200 =C2=B1  2%     -23.3%       3986 =C2=B1  9%  =
interrupts.CPU128.PMI:Performance_monitoring_interrupts
>>     663.33 =C2=B1  4%     +74.6%       1158 =C2=B1  6%  =
interrupts.CPU128.RES:Rescheduling_interrupts
>>     472.33 =C2=B1 17%    +102.4%     956.00 =C2=B1  8%  =
interrupts.CPU128.TLB:TLB_shootdowns
>>       4075 =C2=B1  8%     +20.3%       4900        =
interrupts.CPU129.CAL:Function_call_interrupts
>>     640.33 =C2=B1  2%     +73.2%       1108 =C2=B1  8%  =
interrupts.CPU129.RES:Rescheduling_interrupts
>>     445.33 =C2=B1 19%    +113.4%     950.25 =C2=B1 11%  =
interrupts.CPU129.TLB:TLB_shootdowns
>>       8340 =C2=B1 68%     -76.0%       2003 =C2=B1 74%  =
interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3
>>       4049 =C2=B1  7%     +20.6%       4885 =C2=B1  2%  =
interrupts.CPU13.CAL:Function_call_interrupts
>>       5130 =C2=B1  3%     -24.2%       3886 =C2=B1  5%  =
interrupts.CPU13.NMI:Non-maskable_interrupts
>>       5130 =C2=B1  3%     -24.2%       3886 =C2=B1  5%  =
interrupts.CPU13.PMI:Performance_monitoring_interrupts
>>     724.00 =C2=B1  5%     +57.8%       1142 =C2=B1  5%  =
interrupts.CPU13.RES:Rescheduling_interrupts
>>     532.67 =C2=B1 23%     +70.5%     908.25 =C2=B1 12%  =
interrupts.CPU13.TLB:TLB_shootdowns
>>       3881 =C2=B1  6%     +30.0%       5044 =C2=B1  4%  =
interrupts.CPU130.CAL:Function_call_interrupts
>>     621.33 =C2=B1 10%     +89.4%       1176 =C2=B1  8%  =
interrupts.CPU130.RES:Rescheduling_interrupts
>>     516.33 =C2=B1 16%     +92.9%     996.25 =C2=B1 15%  =
interrupts.CPU130.TLB:TLB_shootdowns
>>       4035 =C2=B1  2%     +22.0%       4923 =C2=B1  3%  =
interrupts.CPU131.CAL:Function_call_interrupts
>>     661.67 =C2=B1  7%     +69.5%       1121 =C2=B1  4%  =
interrupts.CPU131.RES:Rescheduling_interrupts
>>     425.67 =C2=B1 11%    +116.8%     922.75 =C2=B1 15%  =
interrupts.CPU131.TLB:TLB_shootdowns
>>       4345 =C2=B1  3%     +13.3%       4924 =C2=B1  5%  =
interrupts.CPU132.CAL:Function_call_interrupts
>>     694.00           +68.9%       1172 =C2=B1  5%  =
interrupts.CPU132.RES:Rescheduling_interrupts
>>     476.00 =C2=B1 11%     +94.5%     926.00 =C2=B1 13%  =
interrupts.CPU132.TLB:TLB_shootdowns
>>       4091 =C2=B1  7%     +22.7%       5018 =C2=B1  4%  =
interrupts.CPU133.CAL:Function_call_interrupts
>>     663.67 =C2=B1  6%     +68.6%       1119 =C2=B1  4%  =
interrupts.CPU133.RES:Rescheduling_interrupts
>>     534.33 =C2=B1  9%     +78.7%     954.75 =C2=B1 13%  =
interrupts.CPU133.TLB:TLB_shootdowns
>>       3856 =C2=B1  7%     +26.7%       4886 =C2=B1  3%  =
interrupts.CPU134.CAL:Function_call_interrupts
>>       5199 =C2=B1  2%     -34.5%       3406 =C2=B1 24%  =
interrupts.CPU134.NMI:Non-maskable_interrupts
>>       5199 =C2=B1  2%     -34.5%       3406 =C2=B1 24%  =
interrupts.CPU134.PMI:Performance_monitoring_interrupts
>>     667.00 =C2=B1 13%     +74.7%       1165 =C2=B1  6%  =
interrupts.CPU134.RES:Rescheduling_interrupts
>>     447.33 =C2=B1  9%    +116.7%     969.25 =C2=B1  3%  =
interrupts.CPU134.TLB:TLB_shootdowns
>>       4120 =C2=B1 11%     +18.6%       4886 =C2=B1  3%  =
interrupts.CPU135.CAL:Function_call_interrupts
>>       5233 =C2=B1  3%     -24.8%       3934 =C2=B1  9%  =
interrupts.CPU135.NMI:Non-maskable_interrupts
>>       5233 =C2=B1  3%     -24.8%       3934 =C2=B1  9%  =
interrupts.CPU135.PMI:Performance_monitoring_interrupts
>>     643.67 =C2=B1  5%     +81.8%       1170 =C2=B1  7%  =
interrupts.CPU135.RES:Rescheduling_interrupts
>>     490.00 =C2=B1 17%     +88.4%     923.00 =C2=B1 18%  =
interrupts.CPU135.TLB:TLB_shootdowns
>>       4092 =C2=B1  3%     +22.8%       5026 =C2=B1  3%  =
interrupts.CPU136.CAL:Function_call_interrupts
>>       5225 =C2=B1  3%     -34.3%       3430 =C2=B1 26%  =
interrupts.CPU136.NMI:Non-maskable_interrupts
>>       5225 =C2=B1  3%     -34.3%       3430 =C2=B1 26%  =
interrupts.CPU136.PMI:Performance_monitoring_interrupts
>>     673.33 =C2=B1  4%     +80.6%       1216 =C2=B1  4%  =
interrupts.CPU136.RES:Rescheduling_interrupts
>>     488.00 =C2=B1  8%     +87.9%     916.75 =C2=B1 13%  =
interrupts.CPU136.TLB:TLB_shootdowns
>>       4234 =C2=B1  9%     +16.3%       4925 =C2=B1  4%  =
interrupts.CPU137.CAL:Function_call_interrupts
>>       5217 =C2=B1  4%     -34.5%       3418 =C2=B1 24%  =
interrupts.CPU137.NMI:Non-maskable_interrupts
>>       5217 =C2=B1  4%     -34.5%       3418 =C2=B1 24%  =
interrupts.CPU137.PMI:Performance_monitoring_interrupts
>>     625.33 =C2=B1 14%     +87.5%       1172 =C2=B1  6%  =
interrupts.CPU137.RES:Rescheduling_interrupts
>>     441.67 =C2=B1 10%    +115.5%     951.75 =C2=B1 13%  =
interrupts.CPU137.TLB:TLB_shootdowns
>>       3987 =C2=B1  6%     +23.1%       4907 =C2=B1  2%  =
interrupts.CPU138.CAL:Function_call_interrupts
>>       5218 =C2=B1  3%     -42.7%       2992 =C2=B1 38%  =
interrupts.CPU138.NMI:Non-maskable_interrupts
>>       5218 =C2=B1  3%     -42.7%       2992 =C2=B1 38%  =
interrupts.CPU138.PMI:Performance_monitoring_interrupts
>>     672.33 =C2=B1  3%     +76.5%       1186 =C2=B1  4%  =
interrupts.CPU138.RES:Rescheduling_interrupts
>>     439.67 =C2=B1  8%    +113.4%     938.25 =C2=B1 11%  =
interrupts.CPU138.TLB:TLB_shootdowns
>>       4040 =C2=B1  7%     +23.1%       4973 =C2=B1  4%  =
interrupts.CPU139.CAL:Function_call_interrupts
>>     635.33 =C2=B1  3%     +85.3%       1177 =C2=B1  7%  =
interrupts.CPU139.RES:Rescheduling_interrupts
>>     425.33 =C2=B1 17%    +110.7%     896.00 =C2=B1 10%  =
interrupts.CPU139.TLB:TLB_shootdowns
>>       3920 =C2=B1  2%     +21.7%       4771 =C2=B1  2%  =
interrupts.CPU14.CAL:Function_call_interrupts
>>       5123 =C2=B1  4%     -43.3%       2903 =C2=B1 30%  =
interrupts.CPU14.NMI:Non-maskable_interrupts
>>       5123 =C2=B1  4%     -43.3%       2903 =C2=B1 30%  =
interrupts.CPU14.PMI:Performance_monitoring_interrupts
>>     725.00 =C2=B1 12%     +56.2%       1132 =C2=B1  6%  =
interrupts.CPU14.RES:Rescheduling_interrupts
>>     402.00 =C2=B1  6%    +110.0%     844.25 =C2=B1 10%  =
interrupts.CPU14.TLB:TLB_shootdowns
>>       4006 =C2=B1 11%     +19.8%       4800 =C2=B1  3%  =
interrupts.CPU140.CAL:Function_call_interrupts
>>       5230 =C2=B1  3%     -24.8%       3932 =C2=B1 10%  =
interrupts.CPU140.NMI:Non-maskable_interrupts
>>       5230 =C2=B1  3%     -24.8%       3932 =C2=B1 10%  =
interrupts.CPU140.PMI:Performance_monitoring_interrupts
>>     578.33 =C2=B1  3%    +102.5%       1171 =C2=B1  5%  =
interrupts.CPU140.RES:Rescheduling_interrupts
>>     506.00 =C2=B1  5%     +90.3%     963.00 =C2=B1 11%  =
interrupts.CPU140.TLB:TLB_shootdowns
>>       4080 =C2=B1  6%     +25.8%       5131 =C2=B1  7%  =
interrupts.CPU141.CAL:Function_call_interrupts
>>       5148 =C2=B1  4%     -33.6%       3418 =C2=B1 25%  =
interrupts.CPU141.NMI:Non-maskable_interrupts
>>       5148 =C2=B1  4%     -33.6%       3418 =C2=B1 25%  =
interrupts.CPU141.PMI:Performance_monitoring_interrupts
>>     695.00 =C2=B1  3%     +74.7%       1214 =C2=B1  7%  =
interrupts.CPU141.RES:Rescheduling_interrupts
>>     503.33 =C2=B1 23%    +150.9%       1263 =C2=B1 44%  =
interrupts.CPU141.TLB:TLB_shootdowns
>>       4155 =C2=B1  8%     +16.6%       4843 =C2=B1  4%  =
interrupts.CPU142.CAL:Function_call_interrupts
>>     638.00 =C2=B1  6%     +82.1%       1161 =C2=B1  6%  =
interrupts.CPU142.RES:Rescheduling_interrupts
>>     509.33 =C2=B1  8%     +89.0%     962.50 =C2=B1 14%  =
interrupts.CPU142.TLB:TLB_shootdowns
>>       4018 =C2=B1  6%     +24.3%       4993        =
interrupts.CPU143.CAL:Function_call_interrupts
>>     643.67 =C2=B1  2%     +86.6%       1201 =C2=B1  8%  =
interrupts.CPU143.RES:Rescheduling_interrupts
>>     553.67 =C2=B1  7%     +83.0%       1013 =C2=B1 10%  =
interrupts.CPU143.TLB:TLB_shootdowns
>>       3990 =C2=B1  5%     +25.0%       4989 =C2=B1  4%  =
interrupts.CPU144.CAL:Function_call_interrupts
>>     654.00 =C2=B1 10%     +78.0%       1164 =C2=B1  4%  =
interrupts.CPU144.RES:Rescheduling_interrupts
>>     415.33 =C2=B1  4%    +124.9%     934.25 =C2=B1  9%  =
interrupts.CPU144.TLB:TLB_shootdowns
>>       3875 =C2=B1  3%     +30.5%       5056 =C2=B1  6%  =
interrupts.CPU145.CAL:Function_call_interrupts
>>     647.00 =C2=B1 13%     +79.9%       1163 =C2=B1  4%  =
interrupts.CPU145.RES:Rescheduling_interrupts
>>     445.67 =C2=B1 16%    +112.7%     947.75 =C2=B1 12%  =
interrupts.CPU145.TLB:TLB_shootdowns
>>       3891 =C2=B1  7%     +24.8%       4857 =C2=B1  5%  =
interrupts.CPU146.CAL:Function_call_interrupts
>>     635.00 =C2=B1  6%     +80.7%       1147 =C2=B1  5%  =
interrupts.CPU146.RES:Rescheduling_interrupts
>>     438.67 =C2=B1 11%    +127.1%     996.25 =C2=B1 10%  =
interrupts.CPU146.TLB:TLB_shootdowns
>>       3899 =C2=B1  7%     +28.0%       4990 =C2=B1  4%  =
interrupts.CPU147.CAL:Function_call_interrupts
>>       5189 =C2=B1  3%     -24.6%       3915 =C2=B1 10%  =
interrupts.CPU147.NMI:Non-maskable_interrupts
>>       5189 =C2=B1  3%     -24.6%       3915 =C2=B1 10%  =
interrupts.CPU147.PMI:Performance_monitoring_interrupts
>>     643.33           +80.3%       1160 =C2=B1  2%  =
interrupts.CPU147.RES:Rescheduling_interrupts
>>     430.00 =C2=B1 16%    +116.9%     932.50 =C2=B1 17%  =
interrupts.CPU147.TLB:TLB_shootdowns
>>       4129 =C2=B1 12%     +18.4%       4889        =
interrupts.CPU148.CAL:Function_call_interrupts
>>       5219 =C2=B1  3%     -24.7%       3932 =C2=B1  9%  =
interrupts.CPU148.NMI:Non-maskable_interrupts
>>       5219 =C2=B1  3%     -24.7%       3932 =C2=B1  9%  =
interrupts.CPU148.PMI:Performance_monitoring_interrupts
>>     588.33 =C2=B1  7%     +93.6%       1139 =C2=B1  5%  =
interrupts.CPU148.RES:Rescheduling_interrupts
>>     501.00 =C2=B1 16%     +78.7%     895.25 =C2=B1  8%  =
interrupts.CPU148.TLB:TLB_shootdowns
>>       4186 =C2=B1  9%     +18.3%       4953 =C2=B1  3%  =
interrupts.CPU149.CAL:Function_call_interrupts
>>       5185 =C2=B1  4%     -32.3%       3509 =C2=B1 31%  =
interrupts.CPU149.NMI:Non-maskable_interrupts
>>       5185 =C2=B1  4%     -32.3%       3509 =C2=B1 31%  =
interrupts.CPU149.PMI:Performance_monitoring_interrupts
>>     638.67           +70.9%       1091 =C2=B1  2%  =
interrupts.CPU149.RES:Rescheduling_interrupts
>>     558.33 =C2=B1 15%     +71.8%     959.25 =C2=B1  7%  =
interrupts.CPU149.TLB:TLB_shootdowns
>>       3912 =C2=B1  6%     +21.4%       4750 =C2=B1  4%  =
interrupts.CPU15.CAL:Function_call_interrupts
>>       5197 =C2=B1  3%     -22.8%       4013 =C2=B1  4%  =
interrupts.CPU15.NMI:Non-maskable_interrupts
>>       5197 =C2=B1  3%     -22.8%       4013 =C2=B1  4%  =
interrupts.CPU15.PMI:Performance_monitoring_interrupts
>>     776.33 =C2=B1  7%     +39.1%       1080 =C2=B1  6%  =
interrupts.CPU15.RES:Rescheduling_interrupts
>>     473.00 =C2=B1 12%     +98.5%     938.75 =C2=B1 11%  =
interrupts.CPU15.TLB:TLB_shootdowns
>>       4178 =C2=B1  9%     +18.1%       4936 =C2=B1  4%  =
interrupts.CPU150.CAL:Function_call_interrupts
>>       5192 =C2=B1  4%     -25.4%       3873 =C2=B1 10%  =
interrupts.CPU150.NMI:Non-maskable_interrupts
>>       5192 =C2=B1  4%     -25.4%       3873 =C2=B1 10%  =
interrupts.CPU150.PMI:Performance_monitoring_interrupts
>>     678.67 =C2=B1  8%     +64.3%       1115 =C2=B1  5%  =
interrupts.CPU150.RES:Rescheduling_interrupts
>>     513.33 =C2=B1 28%     +73.6%     891.00 =C2=B1 21%  =
interrupts.CPU150.TLB:TLB_shootdowns
>>       4052 =C2=B1  6%     +21.9%       4939 =C2=B1  3%  =
interrupts.CPU151.CAL:Function_call_interrupts
>>       5260 =C2=B1  3%     -25.8%       3903 =C2=B1 10%  =
interrupts.CPU151.NMI:Non-maskable_interrupts
>>       5260 =C2=B1  3%     -25.8%       3903 =C2=B1 10%  =
interrupts.CPU151.PMI:Performance_monitoring_interrupts
>>     623.33 =C2=B1  3%     +86.9%       1164 =C2=B1  4%  =
interrupts.CPU151.RES:Rescheduling_interrupts
>>     484.67 =C2=B1 11%     +98.0%     959.50 =C2=B1  8%  =
interrupts.CPU151.TLB:TLB_shootdowns
>>       3982 =C2=B1  8%     +25.1%       4982 =C2=B1  4%  =
interrupts.CPU152.CAL:Function_call_interrupts
>>       5183 =C2=B1  2%     -32.9%       3475 =C2=B1 26%  =
interrupts.CPU152.NMI:Non-maskable_interrupts
>>       5183 =C2=B1  2%     -32.9%       3475 =C2=B1 26%  =
interrupts.CPU152.PMI:Performance_monitoring_interrupts
>>     623.33 =C2=B1  5%     +79.5%       1119 =C2=B1  2%  =
interrupts.CPU152.RES:Rescheduling_interrupts
>>     494.00 =C2=B1 14%     +89.7%     937.25 =C2=B1  9%  =
interrupts.CPU152.TLB:TLB_shootdowns
>>       4109 =C2=B1  6%     +24.9%       5131 =C2=B1 10%  =
interrupts.CPU153.CAL:Function_call_interrupts
>>       5179 =C2=B1  4%     -31.7%       3536 =C2=B1 31%  =
interrupts.CPU153.NMI:Non-maskable_interrupts
>>       5179 =C2=B1  4%     -31.7%       3536 =C2=B1 31%  =
interrupts.CPU153.PMI:Performance_monitoring_interrupts
>>     614.67 =C2=B1  3%     +94.8%       1197 =C2=B1  9%  =
interrupts.CPU153.RES:Rescheduling_interrupts
>>     486.00 =C2=B1 19%     +83.9%     893.75 =C2=B1 13%  =
interrupts.CPU153.TLB:TLB_shootdowns
>>       4161 =C2=B1  5%     +16.5%       4846 =C2=B1  2%  =
interrupts.CPU154.CAL:Function_call_interrupts
>>     635.33 =C2=B1  3%     +74.6%       1109 =C2=B1  3%  =
interrupts.CPU154.RES:Rescheduling_interrupts
>>     490.67 =C2=B1 21%     +87.4%     919.50 =C2=B1  8%  =
interrupts.CPU154.TLB:TLB_shootdowns
>>       3946 =C2=B1  8%     +28.2%       5057 =C2=B1  2%  =
interrupts.CPU155.CAL:Function_call_interrupts
>>     631.33 =C2=B1  9%     +78.6%       1127 =C2=B1  3%  =
interrupts.CPU155.RES:Rescheduling_interrupts
>>     489.33 =C2=B1 17%    +107.9%       1017 =C2=B1 11%  =
interrupts.CPU155.TLB:TLB_shootdowns
>>       4028 =C2=B1  5%     +21.3%       4887 =C2=B1  4%  =
interrupts.CPU156.CAL:Function_call_interrupts
>>     627.33 =C2=B1  2%     +82.2%       1142 =C2=B1  2%  =
interrupts.CPU156.RES:Rescheduling_interrupts
>>     452.33 =C2=B1 14%    +113.0%     963.25 =C2=B1 15%  =
interrupts.CPU156.TLB:TLB_shootdowns
>>       3893 =C2=B1  8%     +28.2%       4993 =C2=B1  4%  =
interrupts.CPU157.CAL:Function_call_interrupts
>>     637.33           +80.4%       1149 =C2=B1  4%  =
interrupts.CPU157.RES:Rescheduling_interrupts
>>     451.67 =C2=B1 20%    +105.6%     928.50 =C2=B1 11%  =
interrupts.CPU157.TLB:TLB_shootdowns
>>       4155 =C2=B1  9%     +19.6%       4971 =C2=B1  4%  =
interrupts.CPU158.CAL:Function_call_interrupts
>>     628.33 =C2=B1  6%     +75.8%       1104 =C2=B1  2%  =
interrupts.CPU158.RES:Rescheduling_interrupts
>>     468.33 =C2=B1 11%    +103.4%     952.50 =C2=B1 11%  =
interrupts.CPU158.TLB:TLB_shootdowns
>>       3965 =C2=B1  8%     +23.8%       4910 =C2=B1  5%  =
interrupts.CPU159.CAL:Function_call_interrupts
>>     597.33 =C2=B1  4%     +95.2%       1166 =C2=B1  2%  =
interrupts.CPU159.RES:Rescheduling_interrupts
>>     436.00 =C2=B1 12%    +121.7%     966.50 =C2=B1 11%  =
interrupts.CPU159.TLB:TLB_shootdowns
>>       3811 =C2=B1  3%     +28.3%       4890 =C2=B1  6%  =
interrupts.CPU16.CAL:Function_call_interrupts
>>       5211 =C2=B1  3%     -24.1%       3953 =C2=B1  5%  =
interrupts.CPU16.NMI:Non-maskable_interrupts
>>       5211 =C2=B1  3%     -24.1%       3953 =C2=B1  5%  =
interrupts.CPU16.PMI:Performance_monitoring_interrupts
>>     726.67 =C2=B1  6%     +55.9%       1132 =C2=B1  7%  =
interrupts.CPU16.RES:Rescheduling_interrupts
>>     505.67 =C2=B1 13%     +75.1%     885.50 =C2=B1 12%  =
interrupts.CPU16.TLB:TLB_shootdowns
>>       3965 =C2=B1  8%     +24.8%       4948 =C2=B1  6%  =
interrupts.CPU160.CAL:Function_call_interrupts
>>     636.67 =C2=B1  4%     +74.8%       1113 =C2=B1  2%  =
interrupts.CPU160.RES:Rescheduling_interrupts
>>     516.67 =C2=B1 17%     +88.3%     973.00 =C2=B1 14%  =
interrupts.CPU160.TLB:TLB_shootdowns
>>       4054 =C2=B1  8%     +24.2%       5036 =C2=B1  4%  =
interrupts.CPU161.CAL:Function_call_interrupts
>>     601.00 =C2=B1  6%     +89.6%       1139 =C2=B1  3%  =
interrupts.CPU161.RES:Rescheduling_interrupts
>>     514.33 =C2=B1 13%     +81.9%     935.50 =C2=B1 12%  =
interrupts.CPU161.TLB:TLB_shootdowns
>>       4039 =C2=B1 11%     +19.7%       4836 =C2=B1  3%  =
interrupts.CPU162.CAL:Function_call_interrupts
>>     643.33 =C2=B1  7%     +67.2%       1075        =
interrupts.CPU162.RES:Rescheduling_interrupts
>>     469.33 =C2=B1 18%    +107.1%     972.00 =C2=B1  8%  =
interrupts.CPU162.TLB:TLB_shootdowns
>>       4022 =C2=B1  7%     +20.9%       4864 =C2=B1  3%  =
interrupts.CPU163.CAL:Function_call_interrupts
>>     609.33 =C2=B1  3%     +92.5%       1172        =
interrupts.CPU163.RES:Rescheduling_interrupts
>>     431.00 =C2=B1 18%    +146.3%       1061 =C2=B1  6%  =
interrupts.CPU163.TLB:TLB_shootdowns
>>       4036           +20.7%       4869 =C2=B1  4%  =
interrupts.CPU164.CAL:Function_call_interrupts
>>     613.00 =C2=B1  4%     +86.4%       1142 =C2=B1  6%  =
interrupts.CPU164.RES:Rescheduling_interrupts
>>     492.33 =C2=B1 19%     +87.9%     925.25 =C2=B1 10%  =
interrupts.CPU164.TLB:TLB_shootdowns
>>       3957 =C2=B1  3%     +23.4%       4883 =C2=B1  4%  =
interrupts.CPU165.CAL:Function_call_interrupts
>>       4307 =C2=B1 27%     -42.1%       2492 =C2=B1 41%  =
interrupts.CPU165.NMI:Non-maskable_interrupts
>>       4307 =C2=B1 27%     -42.1%       2492 =C2=B1 41%  =
interrupts.CPU165.PMI:Performance_monitoring_interrupts
>>     583.00 =C2=B1 10%     +88.9%       1101 =C2=B1  3%  =
interrupts.CPU165.RES:Rescheduling_interrupts
>>     449.00 =C2=B1 22%    +108.7%     937.25 =C2=B1 13%  =
interrupts.CPU165.TLB:TLB_shootdowns
>>       4219 =C2=B1  5%     +16.9%       4932 =C2=B1  4%  =
interrupts.CPU166.CAL:Function_call_interrupts
>>     624.33 =C2=B1  4%     +76.9%       1104 =C2=B1  5%  =
interrupts.CPU166.RES:Rescheduling_interrupts
>>     484.33 =C2=B1 17%    +100.6%     971.50 =C2=B1 17%  =
interrupts.CPU166.TLB:TLB_shootdowns
>>       4064 =C2=B1 10%     +21.0%       4918 =C2=B1  3%  =
interrupts.CPU167.CAL:Function_call_interrupts
>>     616.67 =C2=B1  6%     +83.5%       1131 =C2=B1  4%  =
interrupts.CPU167.RES:Rescheduling_interrupts
>>     452.00 =C2=B1 12%     +95.7%     884.50 =C2=B1  8%  =
interrupts.CPU167.TLB:TLB_shootdowns
>>       4087 =C2=B1  6%     +19.4%       4879 =C2=B1  6%  =
interrupts.CPU168.CAL:Function_call_interrupts
>>     649.67           +69.1%       1098 =C2=B1  4%  =
interrupts.CPU168.RES:Rescheduling_interrupts
>>     478.33 =C2=B1  6%     +92.4%     920.50 =C2=B1 12%  =
interrupts.CPU168.TLB:TLB_shootdowns
>>       3753 =C2=B1  7%     +20.6%       4524 =C2=B1  4%  =
interrupts.CPU169.CAL:Function_call_interrupts
>>     585.67           +81.9%       1065 =C2=B1  2%  =
interrupts.CPU169.RES:Rescheduling_interrupts
>>     459.00 =C2=B1  4%    +104.2%     937.50 =C2=B1  3%  =
interrupts.CPU169.TLB:TLB_shootdowns
>>       3764 =C2=B1  5%     +28.6%       4841 =C2=B1  3%  =
interrupts.CPU17.CAL:Function_call_interrupts
>>       5198 =C2=B1  3%     -43.0%       2964 =C2=B1 35%  =
interrupts.CPU17.NMI:Non-maskable_interrupts
>>       5198 =C2=B1  3%     -43.0%       2964 =C2=B1 35%  =
interrupts.CPU17.PMI:Performance_monitoring_interrupts
>>     729.33 =C2=B1  5%     +52.1%       1109 =C2=B1  7%  =
interrupts.CPU17.RES:Rescheduling_interrupts
>>     450.67 =C2=B1 10%    +104.4%     921.25 =C2=B1  7%  =
interrupts.CPU17.TLB:TLB_shootdowns
>>       4099 =C2=B1  8%     +24.8%       5118 =C2=B1  5%  =
interrupts.CPU170.CAL:Function_call_interrupts
>>     590.67 =C2=B1  7%     +91.4%       1130        =
interrupts.CPU170.RES:Rescheduling_interrupts
>>     552.33 =C2=B1 17%     +75.9%     971.75 =C2=B1 10%  =
interrupts.CPU170.TLB:TLB_shootdowns
>>       4023 =C2=B1  8%     +19.5%       4808        =
interrupts.CPU171.CAL:Function_call_interrupts
>>     594.67 =C2=B1  7%     +82.6%       1085 =C2=B1  5%  =
interrupts.CPU171.RES:Rescheduling_interrupts
>>     468.33 =C2=B1 13%     +94.0%     908.75 =C2=B1  7%  =
interrupts.CPU171.TLB:TLB_shootdowns
>>       3917 =C2=B1  9%     +25.0%       4895 =C2=B1  5%  =
interrupts.CPU172.CAL:Function_call_interrupts
>>       5248 =C2=B1  3%     -25.4%       3915 =C2=B1 10%  =
interrupts.CPU172.NMI:Non-maskable_interrupts
>>       5248 =C2=B1  3%     -25.4%       3915 =C2=B1 10%  =
interrupts.CPU172.PMI:Performance_monitoring_interrupts
>>     543.00 =C2=B1  3%    +103.6%       1105 =C2=B1  5%  =
interrupts.CPU172.RES:Rescheduling_interrupts
>>     468.67 =C2=B1 15%     +94.0%     909.25 =C2=B1 17%  =
interrupts.CPU172.TLB:TLB_shootdowns
>>       4057 =C2=B1  6%     +22.6%       4975 =C2=B1  2%  =
interrupts.CPU173.CAL:Function_call_interrupts
>>       5158 =C2=B1  5%     -31.7%       3521 =C2=B1 31%  =
interrupts.CPU173.NMI:Non-maskable_interrupts
>>       5158 =C2=B1  5%     -31.7%       3521 =C2=B1 31%  =
interrupts.CPU173.PMI:Performance_monitoring_interrupts
>>     597.67 =C2=B1  5%     +87.9%       1123 =C2=B1  3%  =
interrupts.CPU173.RES:Rescheduling_interrupts
>>     498.67 =C2=B1 19%    +133.2%       1163 =C2=B1 26%  =
interrupts.CPU173.TLB:TLB_shootdowns
>>       3833 =C2=B1  8%     +26.8%       4859 =C2=B1  3%  =
interrupts.CPU174.CAL:Function_call_interrupts
>>       5208 =C2=B1  4%     -24.7%       3920 =C2=B1 11%  =
interrupts.CPU174.NMI:Non-maskable_interrupts
>>       5208 =C2=B1  4%     -24.7%       3920 =C2=B1 11%  =
interrupts.CPU174.PMI:Performance_monitoring_interrupts
>>     570.67 =C2=B1  2%     +91.1%       1090 =C2=B1  7%  =
interrupts.CPU174.RES:Rescheduling_interrupts
>>     470.00 =C2=B1 19%    +108.3%     979.00 =C2=B1 12%  =
interrupts.CPU174.TLB:TLB_shootdowns
>>       4117 =C2=B1  7%     +17.7%       4845 =C2=B1  3%  =
interrupts.CPU175.CAL:Function_call_interrupts
>>       5202 =C2=B1  4%     -25.1%       3896 =C2=B1  8%  =
interrupts.CPU175.NMI:Non-maskable_interrupts
>>       5202 =C2=B1  4%     -25.1%       3896 =C2=B1  8%  =
interrupts.CPU175.PMI:Performance_monitoring_interrupts
>>     638.33 =C2=B1  3%     +70.8%       1090 =C2=B1  5%  =
interrupts.CPU175.RES:Rescheduling_interrupts
>>     463.00 =C2=B1 17%    +104.4%     946.50 =C2=B1  8%  =
interrupts.CPU175.TLB:TLB_shootdowns
>>       4021 =C2=B1  4%     +16.9%       4699 =C2=B1  2%  =
interrupts.CPU176.CAL:Function_call_interrupts
>>     608.67 =C2=B1  6%     +79.4%       1091 =C2=B1  6%  =
interrupts.CPU176.RES:Rescheduling_interrupts
>>     477.33 =C2=B1 10%     +97.2%     941.50 =C2=B1  7%  =
interrupts.CPU176.TLB:TLB_shootdowns
>>       4071 =C2=B1  7%     +15.5%       4702        =
interrupts.CPU177.CAL:Function_call_interrupts
>>     596.33 =C2=B1  4%     +82.2%       1086        =
interrupts.CPU177.RES:Rescheduling_interrupts
>>     435.00 =C2=B1  5%    +114.7%     934.00 =C2=B1 14%  =
interrupts.CPU177.TLB:TLB_shootdowns
>>       4130 =C2=B1  7%     +16.6%       4815 =C2=B1  4%  =
interrupts.CPU178.CAL:Function_call_interrupts
>>     633.33 =C2=B1  4%     +64.1%       1039 =C2=B1  4%  =
interrupts.CPU178.RES:Rescheduling_interrupts
>>     478.67 =C2=B1 15%     +95.2%     934.50 =C2=B1 19%  =
interrupts.CPU178.TLB:TLB_shootdowns
>>       3821 =C2=B1  4%     +26.8%       4846 =C2=B1  3%  =
interrupts.CPU179.CAL:Function_call_interrupts
>>     594.67           +76.6%       1050 =C2=B1  4%  =
interrupts.CPU179.RES:Rescheduling_interrupts
>>     479.00 =C2=B1  7%     +96.5%     941.00 =C2=B1  6%  =
interrupts.CPU179.TLB:TLB_shootdowns
>>       4196 =C2=B1  4%     +16.5%       4890 =C2=B1  5%  =
interrupts.CPU18.CAL:Function_call_interrupts
>>     728.33           +51.1%       1100 =C2=B1  3%  =
interrupts.CPU18.RES:Rescheduling_interrupts
>>     506.00 =C2=B1 11%     +71.7%     868.75 =C2=B1  6%  =
interrupts.CPU18.TLB:TLB_shootdowns
>>       3950 =C2=B1  6%     +23.3%       4870 =C2=B1  2%  =
interrupts.CPU180.CAL:Function_call_interrupts
>>     606.33 =C2=B1  8%     +72.5%       1045 =C2=B1  2%  =
interrupts.CPU180.RES:Rescheduling_interrupts
>>     498.00 =C2=B1  5%     +72.3%     858.00 =C2=B1 17%  =
interrupts.CPU180.TLB:TLB_shootdowns
>>       4113 =C2=B1 11%     +18.3%       4864 =C2=B1  5%  =
interrupts.CPU181.CAL:Function_call_interrupts
>>     620.33 =C2=B1  4%     +73.7%       1077 =C2=B1  5%  =
interrupts.CPU181.RES:Rescheduling_interrupts
>>     483.33 =C2=B1  5%     +90.3%     919.75 =C2=B1 11%  =
interrupts.CPU181.TLB:TLB_shootdowns
>>       4070 =C2=B1  8%     +17.0%       4761 =C2=B1  2%  =
interrupts.CPU182.CAL:Function_call_interrupts
>>     588.00 =C2=B1  7%     +82.8%       1075 =C2=B1  3%  =
interrupts.CPU182.RES:Rescheduling_interrupts
>>     480.00 =C2=B1 17%    +124.7%       1078 =C2=B1 10%  =
interrupts.CPU182.TLB:TLB_shootdowns
>>       4198 =C2=B1  7%     +15.9%       4868 =C2=B1  2%  =
interrupts.CPU183.CAL:Function_call_interrupts
>>     681.33 =C2=B1  6%     +59.5%       1087 =C2=B1  6%  =
interrupts.CPU183.RES:Rescheduling_interrupts
>>     509.33 =C2=B1 16%     +78.5%     909.00 =C2=B1 15%  =
interrupts.CPU183.TLB:TLB_shootdowns
>>       3955 =C2=B1  2%     +25.7%       4970 =C2=B1  3%  =
interrupts.CPU184.CAL:Function_call_interrupts
>>     565.00 =C2=B1  6%     +93.8%       1095 =C2=B1  6%  =
interrupts.CPU184.RES:Rescheduling_interrupts
>>     443.67 =C2=B1 14%    +107.0%     918.25 =C2=B1  9%  =
interrupts.CPU184.TLB:TLB_shootdowns
>>       4105 =C2=B1  6%     +16.5%       4781 =C2=B1  5%  =
interrupts.CPU185.CAL:Function_call_interrupts
>>     546.67 =C2=B1  5%    +105.8%       1125 =C2=B1  7%  =
interrupts.CPU185.RES:Rescheduling_interrupts
>>     505.00 =C2=B1 18%     +86.8%     943.50 =C2=B1  8%  =
interrupts.CPU185.TLB:TLB_shootdowns
>>       4067 =C2=B1  6%     +19.9%       4878 =C2=B1  3%  =
interrupts.CPU186.CAL:Function_call_interrupts
>>     604.67 =C2=B1  6%     +71.2%       1035 =C2=B1  7%  =
interrupts.CPU186.RES:Rescheduling_interrupts
>>     486.67 =C2=B1 12%     +89.7%     923.25 =C2=B1  8%  =
interrupts.CPU186.TLB:TLB_shootdowns
>>     588.00 =C2=B1  6%     +77.9%       1046 =C2=B1  5%  =
interrupts.CPU187.RES:Rescheduling_interrupts
>>     499.67 =C2=B1 15%     +86.2%     930.50 =C2=B1 15%  =
interrupts.CPU187.TLB:TLB_shootdowns
>>       4186 =C2=B1  5%     +17.1%       4901 =C2=B1  5%  =
interrupts.CPU188.CAL:Function_call_interrupts
>>     616.33 =C2=B1  2%     +77.1%       1091 =C2=B1  4%  =
interrupts.CPU188.RES:Rescheduling_interrupts
>>     461.33 =C2=B1  9%    +102.1%     932.25 =C2=B1 15%  =
interrupts.CPU188.TLB:TLB_shootdowns
>>       3980 =C2=B1  6%     +21.8%       4849 =C2=B1  2%  =
interrupts.CPU189.CAL:Function_call_interrupts
>>     594.33           +87.8%       1116 =C2=B1  3%  =
interrupts.CPU189.RES:Rescheduling_interrupts
>>     431.33 =C2=B1 10%    +126.0%     974.75 =C2=B1  5%  =
interrupts.CPU189.TLB:TLB_shootdowns
>>       3937 =C2=B1  5%     +21.2%       4772 =C2=B1  5%  =
interrupts.CPU19.CAL:Function_call_interrupts
>>       5173 =C2=B1  3%     -31.9%       3525 =C2=B1 25%  =
interrupts.CPU19.NMI:Non-maskable_interrupts
>>       5173 =C2=B1  3%     -31.9%       3525 =C2=B1 25%  =
interrupts.CPU19.PMI:Performance_monitoring_interrupts
>>     722.67 =C2=B1  9%     +48.1%       1070 =C2=B1  2%  =
interrupts.CPU19.RES:Rescheduling_interrupts
>>     479.67 =C2=B1 18%     +95.3%     937.00 =C2=B1  9%  =
interrupts.CPU19.TLB:TLB_shootdowns
>>       3905 =C2=B1  5%     +25.2%       4890 =C2=B1  5%  =
interrupts.CPU190.CAL:Function_call_interrupts
>>       5230 =C2=B1  2%     -24.7%       3937 =C2=B1 10%  =
interrupts.CPU190.NMI:Non-maskable_interrupts
>>       5230 =C2=B1  2%     -24.7%       3937 =C2=B1 10%  =
interrupts.CPU190.PMI:Performance_monitoring_interrupts
>>     580.33 =C2=B1  3%     +84.6%       1071 =C2=B1  2%  =
interrupts.CPU190.RES:Rescheduling_interrupts
>>     454.33 =C2=B1 12%    +111.7%     961.75 =C2=B1 14%  =
interrupts.CPU190.TLB:TLB_shootdowns
>>       3985 =C2=B1  4%     +23.4%       4918 =C2=B1  4%  =
interrupts.CPU191.CAL:Function_call_interrupts
>>       5184 =C2=B1  4%     -34.0%       3422 =C2=B1 24%  =
interrupts.CPU191.NMI:Non-maskable_interrupts
>>       5184 =C2=B1  4%     -34.0%       3422 =C2=B1 24%  =
interrupts.CPU191.PMI:Performance_monitoring_interrupts
>>     589.67 =C2=B1  2%     +91.5%       1129 =C2=B1  7%  =
interrupts.CPU191.RES:Rescheduling_interrupts
>>     498.67 =C2=B1 25%    +102.2%       1008 =C2=B1 14%  =
interrupts.CPU191.TLB:TLB_shootdowns
>>       3847 =C2=B1  6%     +29.1%       4965 =C2=B1  8%  =
interrupts.CPU2.CAL:Function_call_interrupts
>>       5162 =C2=B1  3%     -23.5%       3948 =C2=B1  5%  =
interrupts.CPU2.NMI:Non-maskable_interrupts
>>       5162 =C2=B1  3%     -23.5%       3948 =C2=B1  5%  =
interrupts.CPU2.PMI:Performance_monitoring_interrupts
>>     691.33 =C2=B1  3%     +59.0%       1099 =C2=B1  7%  =
interrupts.CPU2.RES:Rescheduling_interrupts
>>     486.67 =C2=B1  6%     +83.7%     894.25 =C2=B1 13%  =
interrupts.CPU2.TLB:TLB_shootdowns
>>       4000 =C2=B1  3%     +19.6%       4786 =C2=B1  5%  =
interrupts.CPU20.CAL:Function_call_interrupts
>>       5181 =C2=B1  2%     -42.1%       2999 =C2=B1 32%  =
interrupts.CPU20.NMI:Non-maskable_interrupts
>>       5181 =C2=B1  2%     -42.1%       2999 =C2=B1 32%  =
interrupts.CPU20.PMI:Performance_monitoring_interrupts
>>     774.00 =C2=B1 11%     +45.8%       1128 =C2=B1  5%  =
interrupts.CPU20.RES:Rescheduling_interrupts
>>     458.33 =C2=B1 11%    +111.7%     970.25 =C2=B1 12%  =
interrupts.CPU20.TLB:TLB_shootdowns
>>       4143 =C2=B1  4%     +13.1%       4684 =C2=B1  3%  =
interrupts.CPU21.CAL:Function_call_interrupts
>>     814.67 =C2=B1 19%     +35.1%       1100 =C2=B1  6%  =
interrupts.CPU21.RES:Rescheduling_interrupts
>>     453.67 =C2=B1 12%     +97.1%     894.25 =C2=B1 13%  =
interrupts.CPU21.TLB:TLB_shootdowns
>>       3936           +26.2%       4968 =C2=B1  4%  =
interrupts.CPU22.CAL:Function_call_interrupts
>>       5194 =C2=B1  2%     -22.7%       4017 =C2=B1  5%  =
interrupts.CPU22.NMI:Non-maskable_interrupts
>>       5194 =C2=B1  2%     -22.7%       4017 =C2=B1  5%  =
interrupts.CPU22.PMI:Performance_monitoring_interrupts
>>     754.67 =C2=B1 11%     +45.8%       1100 =C2=B1  7%  =
interrupts.CPU22.RES:Rescheduling_interrupts
>>     467.67 =C2=B1 14%    +100.0%     935.25 =C2=B1 17%  =
interrupts.CPU22.TLB:TLB_shootdowns
>>       4046 =C2=B1  4%     +17.6%       4758 =C2=B1  2%  =
interrupts.CPU23.CAL:Function_call_interrupts
>>     716.67 =C2=B1  2%     +45.6%       1043 =C2=B1  5%  =
interrupts.CPU23.RES:Rescheduling_interrupts
>>     416.33 =C2=B1  7%    +108.4%     867.50 =C2=B1 12%  =
interrupts.CPU23.TLB:TLB_shootdowns
>>       4323 =C2=B1  6%     +17.2%       5066 =C2=B1  5%  =
interrupts.CPU24.CAL:Function_call_interrupts
>>       5170 =C2=B1  3%     -22.1%       4027 =C2=B1  6%  =
interrupts.CPU24.NMI:Non-maskable_interrupts
>>       5170 =C2=B1  3%     -22.1%       4027 =C2=B1  6%  =
interrupts.CPU24.PMI:Performance_monitoring_interrupts
>>     876.33 =C2=B1  4%     +33.1%       1166 =C2=B1  6%  =
interrupts.CPU24.RES:Rescheduling_interrupts
>>     678.33 =C2=B1 16%     +50.4%       1020 =C2=B1  9%  =
interrupts.CPU24.TLB:TLB_shootdowns
>>       4259 =C2=B1  7%     +18.1%       5027 =C2=B1  2%  =
interrupts.CPU25.CAL:Function_call_interrupts
>>       5240 =C2=B1  3%     -23.8%       3993 =C2=B1  8%  =
interrupts.CPU25.NMI:Non-maskable_interrupts
>>       5240 =C2=B1  3%     -23.8%       3993 =C2=B1  8%  =
interrupts.CPU25.PMI:Performance_monitoring_interrupts
>>     791.67 =C2=B1  3%     +44.3%       1142 =C2=B1  7%  =
interrupts.CPU25.RES:Rescheduling_interrupts
>>     594.00 =C2=B1 22%     +62.4%     964.75 =C2=B1 15%  =
interrupts.CPU25.TLB:TLB_shootdowns
>>       4234 =C2=B1 13%     +20.7%       5111 =C2=B1  3%  =
interrupts.CPU26.CAL:Function_call_interrupts
>>     821.33 =C2=B1  3%     +41.4%       1161 =C2=B1  6%  =
interrupts.CPU26.RES:Rescheduling_interrupts
>>     528.00 =C2=B1  5%     +96.6%       1038 =C2=B1 18%  =
interrupts.CPU26.TLB:TLB_shootdowns
>>       4202 =C2=B1  4%     +21.4%       5101 =C2=B1  4%  =
interrupts.CPU27.CAL:Function_call_interrupts
>>       5218 =C2=B1  2%     -22.5%       4045 =C2=B1  8%  =
interrupts.CPU27.NMI:Non-maskable_interrupts
>>       5218 =C2=B1  2%     -22.5%       4045 =C2=B1  8%  =
interrupts.CPU27.PMI:Performance_monitoring_interrupts
>>     720.00 =C2=B1  5%     +58.6%       1142 =C2=B1  5%  =
interrupts.CPU27.RES:Rescheduling_interrupts
>>     502.67 =C2=B1 16%     +89.7%     953.50 =C2=B1 12%  =
interrupts.CPU27.TLB:TLB_shootdowns
>>       4162 =C2=B1 14%     +18.2%       4921 =C2=B1  5%  =
interrupts.CPU28.CAL:Function_call_interrupts
>>       5157 =C2=B1  2%     -23.4%       3951 =C2=B1  7%  =
interrupts.CPU28.NMI:Non-maskable_interrupts
>>       5157 =C2=B1  2%     -23.4%       3951 =C2=B1  7%  =
interrupts.CPU28.PMI:Performance_monitoring_interrupts
>>     755.33 =C2=B1  3%     +47.4%       1113 =C2=B1  5%  =
interrupts.CPU28.RES:Rescheduling_interrupts
>>     497.00 =C2=B1 10%     +91.9%     953.50 =C2=B1  3%  =
interrupts.CPU28.TLB:TLB_shootdowns
>>       4088 =C2=B1  5%     +24.1%       5072 =C2=B1  6%  =
interrupts.CPU29.CAL:Function_call_interrupts
>>       5188 =C2=B1  3%     -22.5%       4021 =C2=B1  6%  =
interrupts.CPU29.NMI:Non-maskable_interrupts
>>       5188 =C2=B1  3%     -22.5%       4021 =C2=B1  6%  =
interrupts.CPU29.PMI:Performance_monitoring_interrupts
>>     719.33 =C2=B1  6%     +57.0%       1129 =C2=B1  6%  =
interrupts.CPU29.RES:Rescheduling_interrupts
>>     464.33 =C2=B1  2%    +131.1%       1073 =C2=B1 26%  =
interrupts.CPU29.TLB:TLB_shootdowns
>>       3770           +25.7%       4739 =C2=B1  5%  =
interrupts.CPU3.CAL:Function_call_interrupts
>>     746.33 =C2=B1  6%     +50.2%       1120 =C2=B1 11%  =
interrupts.CPU3.RES:Rescheduling_interrupts
>>     511.67 =C2=B1 14%     +74.5%     892.75 =C2=B1  6%  =
interrupts.CPU3.TLB:TLB_shootdowns
>>       4203 =C2=B1  7%     +18.9%       4998 =C2=B1  3%  =
interrupts.CPU30.CAL:Function_call_interrupts
>>       5183 =C2=B1  3%     -41.1%       3055 =C2=B1 37%  =
interrupts.CPU30.NMI:Non-maskable_interrupts
>>       5183 =C2=B1  3%     -41.1%       3055 =C2=B1 37%  =
interrupts.CPU30.PMI:Performance_monitoring_interrupts
>>     749.33 =C2=B1  5%     +52.9%       1146 =C2=B1  6%  =
interrupts.CPU30.RES:Rescheduling_interrupts
>>     469.33 =C2=B1 17%    +108.5%     978.75 =C2=B1  8%  =
interrupts.CPU30.TLB:TLB_shootdowns
>>       4133 =C2=B1  5%     +20.3%       4971 =C2=B1  2%  =
interrupts.CPU31.CAL:Function_call_interrupts
>>       5174 =C2=B1  3%     -31.7%       3536 =C2=B1 26%  =
interrupts.CPU31.NMI:Non-maskable_interrupts
>>       5174 =C2=B1  3%     -31.7%       3536 =C2=B1 26%  =
interrupts.CPU31.PMI:Performance_monitoring_interrupts
>>     777.33 =C2=B1  5%     +53.8%       1195 =C2=B1  5%  =
interrupts.CPU31.RES:Rescheduling_interrupts
>>     496.00 =C2=B1  9%     +96.7%     975.75 =C2=B1 16%  =
interrupts.CPU31.TLB:TLB_shootdowns
>>       4107 =C2=B1  7%     +18.1%       4849 =C2=B1  2%  =
interrupts.CPU32.CAL:Function_call_interrupts
>>       5163 =C2=B1  3%     -21.8%       4038 =C2=B1  7%  =
interrupts.CPU32.NMI:Non-maskable_interrupts
>>       5163 =C2=B1  3%     -21.8%       4038 =C2=B1  7%  =
interrupts.CPU32.PMI:Performance_monitoring_interrupts
>>     711.67           +52.9%       1088 =C2=B1  5%  =
interrupts.CPU32.RES:Rescheduling_interrupts
>>     489.33 =C2=B1 18%    +115.7%       1055 =C2=B1 11%  =
interrupts.CPU32.TLB:TLB_shootdowns
>>       4170 =C2=B1  4%     +17.4%       4897 =C2=B1  2%  =
interrupts.CPU33.CAL:Function_call_interrupts
>>       5215 =C2=B1  3%     -33.3%       3480 =C2=B1 25%  =
interrupts.CPU33.NMI:Non-maskable_interrupts
>>       5215 =C2=B1  3%     -33.3%       3480 =C2=B1 25%  =
interrupts.CPU33.PMI:Performance_monitoring_interrupts
>>     785.33 =C2=B1  7%     +46.2%       1148 =C2=B1  4%  =
interrupts.CPU33.RES:Rescheduling_interrupts
>>     547.67 =C2=B1 13%     +71.6%     939.75 =C2=B1 11%  =
interrupts.CPU33.TLB:TLB_shootdowns
>>       4302 =C2=B1  6%     +16.0%       4992 =C2=B1  4%  =
interrupts.CPU34.CAL:Function_call_interrupts
>>       5214 =C2=B1  3%     -22.7%       4031 =C2=B1  6%  =
interrupts.CPU34.NMI:Non-maskable_interrupts
>>       5214 =C2=B1  3%     -22.7%       4031 =C2=B1  6%  =
interrupts.CPU34.PMI:Performance_monitoring_interrupts
>>     787.33 =C2=B1  4%     +41.4%       1113 =C2=B1  4%  =
interrupts.CPU34.RES:Rescheduling_interrupts
>>     590.33 =C2=B1  2%     +60.2%     945.50 =C2=B1 11%  =
interrupts.CPU34.TLB:TLB_shootdowns
>>       4044 =C2=B1 11%     +22.9%       4969 =C2=B1  4%  =
interrupts.CPU35.CAL:Function_call_interrupts
>>       5220 =C2=B1  3%     -32.6%       3520 =C2=B1 25%  =
interrupts.CPU35.NMI:Non-maskable_interrupts
>>       5220 =C2=B1  3%     -32.6%       3520 =C2=B1 25%  =
interrupts.CPU35.PMI:Performance_monitoring_interrupts
>>     735.67 =C2=B1  4%     +56.9%       1154 =C2=B1  9%  =
interrupts.CPU35.RES:Rescheduling_interrupts
>>     485.00 =C2=B1 12%    +101.3%     976.50 =C2=B1 11%  =
interrupts.CPU35.TLB:TLB_shootdowns
>>       4291 =C2=B1  8%     +14.9%       4930 =C2=B1  5%  =
interrupts.CPU36.CAL:Function_call_interrupts
>>     782.67 =C2=B1  4%     +51.0%       1182 =C2=B1  4%  =
interrupts.CPU36.RES:Rescheduling_interrupts
>>     491.00 =C2=B1 16%     +84.3%     904.75 =C2=B1 16%  =
interrupts.CPU36.TLB:TLB_shootdowns
>>       3949 =C2=B1  5%     +24.1%       4898 =C2=B1  4%  =
interrupts.CPU37.CAL:Function_call_interrupts
>>     723.67 =C2=B1  3%     +54.0%       1114 =C2=B1  7%  =
interrupts.CPU37.RES:Rescheduling_interrupts
>>     490.00 =C2=B1  9%    +111.4%       1036 =C2=B1  8%  =
interrupts.CPU37.TLB:TLB_shootdowns
>>       5218 =C2=B1  2%     -23.3%       4000 =C2=B1  7%  =
interrupts.CPU38.NMI:Non-maskable_interrupts
>>       5218 =C2=B1  2%     -23.3%       4000 =C2=B1  7%  =
interrupts.CPU38.PMI:Performance_monitoring_interrupts
>>     797.67 =C2=B1 10%     +40.3%       1119 =C2=B1  6%  =
interrupts.CPU38.RES:Rescheduling_interrupts
>>     500.33 =C2=B1 16%     +89.6%     948.50 =C2=B1 12%  =
interrupts.CPU38.TLB:TLB_shootdowns
>>       3987 =C2=B1  5%     +26.0%       5023 =C2=B1  5%  =
interrupts.CPU39.CAL:Function_call_interrupts
>>     772.00           +47.0%       1134 =C2=B1  6%  =
interrupts.CPU39.RES:Rescheduling_interrupts
>>     483.00 =C2=B1 10%    +102.2%     976.75 =C2=B1 17%  =
interrupts.CPU39.TLB:TLB_shootdowns
>>       3933 =C2=B1  6%     +38.0%       5428 =C2=B1 14%  =
interrupts.CPU4.CAL:Function_call_interrupts
>>       5183 =C2=B1  4%     -43.3%       2939 =C2=B1 31%  =
interrupts.CPU4.NMI:Non-maskable_interrupts
>>       5183 =C2=B1  4%     -43.3%       2939 =C2=B1 31%  =
interrupts.CPU4.PMI:Performance_monitoring_interrupts
>>     799.33 =C2=B1  5%     +35.5%       1083 =C2=B1  4%  =
interrupts.CPU4.RES:Rescheduling_interrupts
>>     489.67 =C2=B1 14%    +100.9%     983.50 =C2=B1 11%  =
interrupts.CPU4.TLB:TLB_shootdowns
>>       4034 =C2=B1  6%     +23.7%       4991        =
interrupts.CPU40.CAL:Function_call_interrupts
>>       5212 =C2=B1  2%     -24.0%       3963 =C2=B1  7%  =
interrupts.CPU40.NMI:Non-maskable_interrupts
>>       5212 =C2=B1  2%     -24.0%       3963 =C2=B1  7%  =
interrupts.CPU40.PMI:Performance_monitoring_interrupts
>>     745.67 =C2=B1  5%     +53.6%       1145 =C2=B1  6%  =
interrupts.CPU40.RES:Rescheduling_interrupts
>>     407.67 =C2=B1 11%    +140.6%     981.00 =C2=B1 13%  =
interrupts.CPU40.TLB:TLB_shootdowns
>>       4029 =C2=B1  3%     +25.1%       5040 =C2=B1  4%  =
interrupts.CPU41.CAL:Function_call_interrupts
>>       5237 =C2=B1  2%     -24.0%       3980 =C2=B1  7%  =
interrupts.CPU41.NMI:Non-maskable_interrupts
>>       5237 =C2=B1  2%     -24.0%       3980 =C2=B1  7%  =
interrupts.CPU41.PMI:Performance_monitoring_interrupts
>>     764.00 =C2=B1 11%     +49.6%       1143 =C2=B1 10%  =
interrupts.CPU41.RES:Rescheduling_interrupts
>>     480.33 =C2=B1 15%    +102.8%     974.00 =C2=B1 14%  =
interrupts.CPU41.TLB:TLB_shootdowns
>>       4158 =C2=B1  9%     +19.1%       4950 =C2=B1  5%  =
interrupts.CPU42.CAL:Function_call_interrupts
>>       5205 =C2=B1  2%     -23.9%       3963 =C2=B1  7%  =
interrupts.CPU42.NMI:Non-maskable_interrupts
>>       5205 =C2=B1  2%     -23.9%       3963 =C2=B1  7%  =
interrupts.CPU42.PMI:Performance_monitoring_interrupts
>>     777.00           +48.0%       1150 =C2=B1  7%  =
interrupts.CPU42.RES:Rescheduling_interrupts
>>     494.67 =C2=B1  7%     +85.4%     917.25 =C2=B1  6%  =
interrupts.CPU42.TLB:TLB_shootdowns
>>       4145 =C2=B1  5%     +20.0%       4974 =C2=B1  2%  =
interrupts.CPU43.CAL:Function_call_interrupts
>>       5199 =C2=B1  3%     -23.6%       3971 =C2=B1  6%  =
interrupts.CPU43.NMI:Non-maskable_interrupts
>>       5199 =C2=B1  3%     -23.6%       3971 =C2=B1  6%  =
interrupts.CPU43.PMI:Performance_monitoring_interrupts
>>     734.00 =C2=B1  4%     +54.8%       1136 =C2=B1  3%  =
interrupts.CPU43.RES:Rescheduling_interrupts
>>     479.33 =C2=B1 21%    +116.7%       1038 =C2=B1 12%  =
interrupts.CPU43.TLB:TLB_shootdowns
>>       4038 =C2=B1  6%     +20.5%       4867 =C2=B1  2%  =
interrupts.CPU44.CAL:Function_call_interrupts
>>       5236 =C2=B1  3%     -34.3%       3438 =C2=B1 24%  =
interrupts.CPU44.NMI:Non-maskable_interrupts
>>       5236 =C2=B1  3%     -34.3%       3438 =C2=B1 24%  =
interrupts.CPU44.PMI:Performance_monitoring_interrupts
>>     721.67           +57.3%       1135 =C2=B1  6%  =
interrupts.CPU44.RES:Rescheduling_interrupts
>>     486.67 =C2=B1 12%     +94.9%     948.50 =C2=B1 11%  =
interrupts.CPU44.TLB:TLB_shootdowns
>>       4089 =C2=B1  7%     +19.7%       4895 =C2=B1  4%  =
interrupts.CPU45.CAL:Function_call_interrupts
>>     744.67 =C2=B1  4%     +45.4%       1083 =C2=B1  2%  =
interrupts.CPU45.RES:Rescheduling_interrupts
>>     450.33 =C2=B1 17%    +114.5%     966.00 =C2=B1 19%  =
interrupts.CPU45.TLB:TLB_shootdowns
>>       3816 =C2=B1  5%     +30.8%       4991 =C2=B1  5%  =
interrupts.CPU46.CAL:Function_call_interrupts
>>       5219 =C2=B1  3%     -32.9%       3502 =C2=B1 23%  =
interrupts.CPU46.NMI:Non-maskable_interrupts
>>       5219 =C2=B1  3%     -32.9%       3502 =C2=B1 23%  =
interrupts.CPU46.PMI:Performance_monitoring_interrupts
>>     740.33 =C2=B1  8%     +61.8%       1197 =C2=B1  5%  =
interrupts.CPU46.RES:Rescheduling_interrupts
>>     455.00 =C2=B1  6%    +107.6%     944.75 =C2=B1 15%  =
interrupts.CPU46.TLB:TLB_shootdowns
>>       3989 =C2=B1  2%     +24.0%       4947 =C2=B1  2%  =
interrupts.CPU47.CAL:Function_call_interrupts
>>       5204 =C2=B1  3%     -32.6%       3506 =C2=B1 24%  =
interrupts.CPU47.NMI:Non-maskable_interrupts
>>       5204 =C2=B1  3%     -32.6%       3506 =C2=B1 24%  =
interrupts.CPU47.PMI:Performance_monitoring_interrupts
>>     741.67 =C2=B1  4%     +53.1%       1135 =C2=B1 12%  =
interrupts.CPU47.RES:Rescheduling_interrupts
>>     437.33 =C2=B1 17%    +120.8%     965.75 =C2=B1 16%  =
interrupts.CPU47.TLB:TLB_shootdowns
>>       4165 =C2=B1  2%     +22.3%       5095 =C2=B1  3%  =
interrupts.CPU48.CAL:Function_call_interrupts
>>       5176 =C2=B1  4%     -21.7%       4053 =C2=B1  8%  =
interrupts.CPU48.NMI:Non-maskable_interrupts
>>       5176 =C2=B1  4%     -21.7%       4053 =C2=B1  8%  =
interrupts.CPU48.PMI:Performance_monitoring_interrupts
>>     835.00 =C2=B1  2%     +29.0%       1077 =C2=B1  2%  =
interrupts.CPU48.RES:Rescheduling_interrupts
>>     594.67 =C2=B1 17%     +62.2%     964.50 =C2=B1  5%  =
interrupts.CPU48.TLB:TLB_shootdowns
>>       4171 =C2=B1  9%     +18.7%       4950 =C2=B1  6%  =
interrupts.CPU49.CAL:Function_call_interrupts
>>       5186 =C2=B1  4%     -33.4%       3452 =C2=B1 24%  =
interrupts.CPU49.NMI:Non-maskable_interrupts
>>       5186 =C2=B1  4%     -33.4%       3452 =C2=B1 24%  =
interrupts.CPU49.PMI:Performance_monitoring_interrupts
>>     710.67 =C2=B1  4%     +55.6%       1105 =C2=B1  4%  =
interrupts.CPU49.RES:Rescheduling_interrupts
>>     553.67 =C2=B1  5%     +74.0%     963.25 =C2=B1 10%  =
interrupts.CPU49.TLB:TLB_shootdowns
>>       4064 =C2=B1  6%     +21.6%       4944 =C2=B1  5%  =
interrupts.CPU5.CAL:Function_call_interrupts
>>     772.33 =C2=B1  2%     +45.7%       1125 =C2=B1  4%  =
interrupts.CPU5.RES:Rescheduling_interrupts
>>     491.00 =C2=B1 14%     +95.2%     958.50 =C2=B1 10%  =
interrupts.CPU5.TLB:TLB_shootdowns
>>       3929 =C2=B1  4%     +26.4%       4966 =C2=B1  2%  =
interrupts.CPU50.CAL:Function_call_interrupts
>>       5201 =C2=B1  4%     -22.9%       4011 =C2=B1  7%  =
interrupts.CPU50.NMI:Non-maskable_interrupts
>>       5201 =C2=B1  4%     -22.9%       4011 =C2=B1  7%  =
interrupts.CPU50.PMI:Performance_monitoring_interrupts
>>     747.00 =C2=B1  4%     +40.6%       1050 =C2=B1  3%  =
interrupts.CPU50.RES:Rescheduling_interrupts
>>     482.33 =C2=B1 17%    +103.1%     979.75 =C2=B1 12%  =
interrupts.CPU50.TLB:TLB_shootdowns
>>       4192 =C2=B1  4%     +20.3%       5043 =C2=B1  4%  =
interrupts.CPU51.CAL:Function_call_interrupts
>>       5249 =C2=B1  3%     -24.0%       3987 =C2=B1  7%  =
interrupts.CPU51.NMI:Non-maskable_interrupts
>>       5249 =C2=B1  3%     -24.0%       3987 =C2=B1  7%  =
interrupts.CPU51.PMI:Performance_monitoring_interrupts
>>     780.33 =C2=B1  7%     +54.9%       1209 =C2=B1  9%  =
interrupts.CPU51.RES:Rescheduling_interrupts
>>     504.00 =C2=B1 11%     +95.9%     987.50 =C2=B1  9%  =
interrupts.CPU51.TLB:TLB_shootdowns
>>       4084 =C2=B1  4%     +21.8%       4972 =C2=B1  4%  =
interrupts.CPU52.CAL:Function_call_interrupts
>>       5208 =C2=B1  4%     -23.1%       4006 =C2=B1 11%  =
interrupts.CPU52.NMI:Non-maskable_interrupts
>>       5208 =C2=B1  4%     -23.1%       4006 =C2=B1 11%  =
interrupts.CPU52.PMI:Performance_monitoring_interrupts
>>     724.33 =C2=B1  3%     +48.6%       1076 =C2=B1  4%  =
interrupts.CPU52.RES:Rescheduling_interrupts
>>     536.00 =C2=B1 13%     +91.7%       1027 =C2=B1  7%  =
interrupts.CPU52.TLB:TLB_shootdowns
>>       5184 =C2=B1  3%     -24.1%       3933 =C2=B1 10%  =
interrupts.CPU53.NMI:Non-maskable_interrupts
>>       5184 =C2=B1  3%     -24.1%       3933 =C2=B1 10%  =
interrupts.CPU53.PMI:Performance_monitoring_interrupts
>>     722.67 =C2=B1  4%     +49.1%       1077 =C2=B1  5%  =
interrupts.CPU53.RES:Rescheduling_interrupts
>>     447.33 =C2=B1 20%    +118.6%     978.00 =C2=B1 11%  =
interrupts.CPU53.TLB:TLB_shootdowns
>>       4057 =C2=B1  3%     +25.0%       5073 =C2=B1  5%  =
interrupts.CPU54.CAL:Function_call_interrupts
>>       5172 =C2=B1  4%     -32.6%       3487 =C2=B1 24%  =
interrupts.CPU54.NMI:Non-maskable_interrupts
>>       5172 =C2=B1  4%     -32.6%       3487 =C2=B1 24%  =
interrupts.CPU54.PMI:Performance_monitoring_interrupts
>>     722.67           +50.7%       1088 =C2=B1  7%  =
interrupts.CPU54.RES:Rescheduling_interrupts
>>     491.33 =C2=B1 14%    +382.4%       2370 =C2=B1102%  =
interrupts.CPU54.TLB:TLB_shootdowns
>>       4092 =C2=B1  5%     +17.9%       4825        =
interrupts.CPU55.CAL:Function_call_interrupts
>>     755.67 =C2=B1 10%     +49.2%       1127 =C2=B1  4%  =
interrupts.CPU55.RES:Rescheduling_interrupts
>>     445.67          +117.2%     968.00 =C2=B1 11%  =
interrupts.CPU55.TLB:TLB_shootdowns
>>       4116 =C2=B1  4%     +20.0%       4940 =C2=B1  5%  =
interrupts.CPU56.CAL:Function_call_interrupts
>>       5144 =C2=B1  5%     -33.4%       3427 =C2=B1 23%  =
interrupts.CPU56.NMI:Non-maskable_interrupts
>>       5144 =C2=B1  5%     -33.4%       3427 =C2=B1 23%  =
interrupts.CPU56.PMI:Performance_monitoring_interrupts
>>     707.67           +55.5%       1100        =
interrupts.CPU56.RES:Rescheduling_interrupts
>>     448.00 =C2=B1 16%    +120.1%     986.00 =C2=B1 13%  =
interrupts.CPU56.TLB:TLB_shootdowns
>>       3861           +26.2%       4871 =C2=B1  3%  =
interrupts.CPU57.CAL:Function_call_interrupts
>>       5187 =C2=B1  3%     -33.0%       3474 =C2=B1 25%  =
interrupts.CPU57.NMI:Non-maskable_interrupts
>>       5187 =C2=B1  3%     -33.0%       3474 =C2=B1 25%  =
interrupts.CPU57.PMI:Performance_monitoring_interrupts
>>     703.00 =C2=B1  3%     +55.6%       1094 =C2=B1  4%  =
interrupts.CPU57.RES:Rescheduling_interrupts
>>     495.67 =C2=B1 19%    +106.5%       1023 =C2=B1  8%  =
interrupts.CPU57.TLB:TLB_shootdowns
>>       4003 =C2=B1  6%     +25.3%       5016 =C2=B1  4%  =
interrupts.CPU58.CAL:Function_call_interrupts
>>       5267           -32.7%       3543 =C2=B1 30%  =
interrupts.CPU58.NMI:Non-maskable_interrupts
>>       5267           -32.7%       3543 =C2=B1 30%  =
interrupts.CPU58.PMI:Performance_monitoring_interrupts
>>     692.00           +61.0%       1114        =
interrupts.CPU58.RES:Rescheduling_interrupts
>>     467.67 =C2=B1 16%    +109.8%     981.25 =C2=B1  9%  =
interrupts.CPU58.TLB:TLB_shootdowns
>>       4147 =C2=B1  7%     +21.2%       5024 =C2=B1  4%  =
interrupts.CPU59.CAL:Function_call_interrupts
>>       5175 =C2=B1  3%     -33.9%       3419 =C2=B1 24%  =
interrupts.CPU59.NMI:Non-maskable_interrupts
>>       5175 =C2=B1  3%     -33.9%       3419 =C2=B1 24%  =
interrupts.CPU59.PMI:Performance_monitoring_interrupts
>>     765.00 =C2=B1  2%     +40.8%       1077 =C2=B1  5%  =
interrupts.CPU59.RES:Rescheduling_interrupts
>>     477.67 =C2=B1 23%     +97.7%     944.25 =C2=B1  9%  =
interrupts.CPU59.TLB:TLB_shootdowns
>>       4121 =C2=B1  7%     +19.7%       4932 =C2=B1  4%  =
interrupts.CPU6.CAL:Function_call_interrupts
>>       5158 =C2=B1  4%     -31.8%       3518 =C2=B1 25%  =
interrupts.CPU6.NMI:Non-maskable_interrupts
>>       5158 =C2=B1  4%     -31.8%       3518 =C2=B1 25%  =
interrupts.CPU6.PMI:Performance_monitoring_interrupts
>>     735.33 =C2=B1 10%     +48.5%       1091 =C2=B1  5%  =
interrupts.CPU6.RES:Rescheduling_interrupts
>>     535.33 =C2=B1 13%     +72.5%     923.25 =C2=B1 14%  =
interrupts.CPU6.TLB:TLB_shootdowns
>>       4122 =C2=B1  4%     +32.7%       5471 =C2=B1 18%  =
interrupts.CPU60.CAL:Function_call_interrupts
>>     746.67 =C2=B1  4%     +48.7%       1110 =C2=B1  4%  =
interrupts.CPU60.RES:Rescheduling_interrupts
>>     496.00 =C2=B1 23%     +92.2%     953.25 =C2=B1 13%  =
interrupts.CPU60.TLB:TLB_shootdowns
>>       4022 =C2=B1  4%     +33.7%       5376 =C2=B1 14%  =
interrupts.CPU61.CAL:Function_call_interrupts
>>       5190 =C2=B1  4%     -34.9%       3378 =C2=B1 24%  =
interrupts.CPU61.NMI:Non-maskable_interrupts
>>       5190 =C2=B1  4%     -34.9%       3378 =C2=B1 24%  =
interrupts.CPU61.PMI:Performance_monitoring_interrupts
>>     734.33 =C2=B1  4%     +48.2%       1088 =C2=B1  2%  =
interrupts.CPU61.RES:Rescheduling_interrupts
>>     484.67 =C2=B1 15%    +109.0%       1013 =C2=B1  9%  =
interrupts.CPU61.TLB:TLB_shootdowns
>>       3917 =C2=B1  5%     +26.4%       4953 =C2=B1  3%  =
interrupts.CPU62.CAL:Function_call_interrupts
>>       5189 =C2=B1  4%     -32.8%       3489 =C2=B1 25%  =
interrupts.CPU62.NMI:Non-maskable_interrupts
>>       5189 =C2=B1  4%     -32.8%       3489 =C2=B1 25%  =
interrupts.CPU62.PMI:Performance_monitoring_interrupts
>>     778.00 =C2=B1  3%     +42.6%       1109 =C2=B1  2%  =
interrupts.CPU62.RES:Rescheduling_interrupts
>>     486.33 =C2=B1 23%    +110.0%       1021 =C2=B1 17%  =
interrupts.CPU62.TLB:TLB_shootdowns
>>       4163 =C2=B1  8%     +20.8%       5029        =
interrupts.CPU63.CAL:Function_call_interrupts
>>       5231 =C2=B1  2%     -34.6%       3419 =C2=B1 24%  =
interrupts.CPU63.NMI:Non-maskable_interrupts
>>       5231 =C2=B1  2%     -34.6%       3419 =C2=B1 24%  =
interrupts.CPU63.PMI:Performance_monitoring_interrupts
>>     775.67 =C2=B1  6%     +39.5%       1082        =
interrupts.CPU63.RES:Rescheduling_interrupts
>>     491.00 =C2=B1 22%     +95.8%     961.25 =C2=B1 16%  =
interrupts.CPU63.TLB:TLB_shootdowns
>>       4016 =C2=B1  2%     +24.2%       4990 =C2=B1  3%  =
interrupts.CPU64.CAL:Function_call_interrupts
>>       5129 =C2=B1  5%     -42.0%       2973 =C2=B1 36%  =
interrupts.CPU64.NMI:Non-maskable_interrupts
>>       5129 =C2=B1  5%     -42.0%       2973 =C2=B1 36%  =
interrupts.CPU64.PMI:Performance_monitoring_interrupts
>>     757.67 =C2=B1  4%     +47.7%       1119 =C2=B1  3%  =
interrupts.CPU64.RES:Rescheduling_interrupts
>>     453.67 =C2=B1 11%    +119.8%     997.00 =C2=B1 11%  =
interrupts.CPU64.TLB:TLB_shootdowns
>>       3854 =C2=B1  2%     +26.3%       4868 =C2=B1  7%  =
interrupts.CPU65.CAL:Function_call_interrupts
>>     767.33 =C2=B1  7%     +37.7%       1056 =C2=B1  3%  =
interrupts.CPU65.RES:Rescheduling_interrupts
>>     519.67 =C2=B1 14%     +85.3%     962.75 =C2=B1 13%  =
interrupts.CPU65.TLB:TLB_shootdowns
>>       3915 =C2=B1  8%     +24.8%       4888 =C2=B1  3%  =
interrupts.CPU66.CAL:Function_call_interrupts
>>       5199 =C2=B1  3%     -34.4%       3409 =C2=B1 25%  =
interrupts.CPU66.NMI:Non-maskable_interrupts
>>       5199 =C2=B1  3%     -34.4%       3409 =C2=B1 25%  =
interrupts.CPU66.PMI:Performance_monitoring_interrupts
>>     712.67 =C2=B1  3%     +56.9%       1118 =C2=B1  6%  =
interrupts.CPU66.RES:Rescheduling_interrupts
>>     431.67 =C2=B1 30%    +138.8%       1030 =C2=B1 14%  =
interrupts.CPU66.TLB:TLB_shootdowns
>>       4026 =C2=B1  9%     +21.0%       4870 =C2=B1  3%  =
interrupts.CPU67.CAL:Function_call_interrupts
>>       5157 =C2=B1  5%     -23.4%       3950 =C2=B1  9%  =
interrupts.CPU67.NMI:Non-maskable_interrupts
>>       5157 =C2=B1  5%     -23.4%       3950 =C2=B1  9%  =
interrupts.CPU67.PMI:Performance_monitoring_interrupts
>>     671.00           +56.9%       1053 =C2=B1  2%  =
interrupts.CPU67.RES:Rescheduling_interrupts
>>     489.67 =C2=B1 16%     +99.6%     977.50 =C2=B1 12%  =
interrupts.CPU67.TLB:TLB_shootdowns
>>       4034 =C2=B1  4%     +22.0%       4921 =C2=B1  2%  =
interrupts.CPU68.CAL:Function_call_interrupts
>>       5175 =C2=B1  4%     -31.2%       3561 =C2=B1 30%  =
interrupts.CPU68.NMI:Non-maskable_interrupts
>>       5175 =C2=B1  4%     -31.2%       3561 =C2=B1 30%  =
interrupts.CPU68.PMI:Performance_monitoring_interrupts
>>     709.00 =C2=B1  4%     +56.2%       1107 =C2=B1  3%  =
interrupts.CPU68.RES:Rescheduling_interrupts
>>     493.00 =C2=B1 15%     +95.8%     965.25 =C2=B1 12%  =
interrupts.CPU68.TLB:TLB_shootdowns
>>       4014 =C2=B1 10%     +24.6%       5001 =C2=B1  2%  =
interrupts.CPU69.CAL:Function_call_interrupts
>>       5152 =C2=B1  4%     -32.5%       3476 =C2=B1 25%  =
interrupts.CPU69.NMI:Non-maskable_interrupts
>>       5152 =C2=B1  4%     -32.5%       3476 =C2=B1 25%  =
interrupts.CPU69.PMI:Performance_monitoring_interrupts
>>     717.33 =C2=B1  3%     +50.3%       1078 =C2=B1  7%  =
interrupts.CPU69.RES:Rescheduling_interrupts
>>     434.67 =C2=B1 26%    +123.0%     969.25 =C2=B1  8%  =
interrupts.CPU69.TLB:TLB_shootdowns
>>       3972 =C2=B1  8%     +23.1%       4892        =
interrupts.CPU7.CAL:Function_call_interrupts
>>     776.67 =C2=B1  5%     +40.6%       1091 =C2=B1  4%  =
interrupts.CPU7.RES:Rescheduling_interrupts
>>     467.33 =C2=B1 11%    +102.8%     947.75 =C2=B1 16%  =
interrupts.CPU7.TLB:TLB_shootdowns
>>       4068 =C2=B1 11%     +26.2%       5134        =
interrupts.CPU70.CAL:Function_call_interrupts
>>       5188 =C2=B1  4%     -42.6%       2975 =C2=B1 37%  =
interrupts.CPU70.NMI:Non-maskable_interrupts
>>       5188 =C2=B1  4%     -42.6%       2975 =C2=B1 37%  =
interrupts.CPU70.PMI:Performance_monitoring_interrupts
>>     718.00 =C2=B1  4%     +54.3%       1107 =C2=B1  2%  =
interrupts.CPU70.RES:Rescheduling_interrupts
>>     494.00 =C2=B1 11%    +104.5%       1010 =C2=B1  6%  =
interrupts.CPU70.TLB:TLB_shootdowns
>>       3920 =C2=B1  4%     +29.5%       5078 =C2=B1  4%  =
interrupts.CPU71.CAL:Function_call_interrupts
>>       5112 =C2=B1  4%     -23.3%       3920 =C2=B1 11%  =
interrupts.CPU71.NMI:Non-maskable_interrupts
>>       5112 =C2=B1  4%     -23.3%       3920 =C2=B1 11%  =
interrupts.CPU71.PMI:Performance_monitoring_interrupts
>>     667.67           +64.9%       1101 =C2=B1  5%  =
interrupts.CPU71.RES:Rescheduling_interrupts
>>     473.00 =C2=B1 13%    +103.8%     963.75 =C2=B1 13%  =
interrupts.CPU71.TLB:TLB_shootdowns
>>       3913 =C2=B1  3%     +26.8%       4963 =C2=B1  2%  =
interrupts.CPU72.CAL:Function_call_interrupts
>>       5206 =C2=B1  3%     -24.5%       3932 =C2=B1 10%  =
interrupts.CPU72.NMI:Non-maskable_interrupts
>>       5206 =C2=B1  3%     -24.5%       3932 =C2=B1 10%  =
interrupts.CPU72.PMI:Performance_monitoring_interrupts
>>     811.67 =C2=B1  3%     +33.3%       1081 =C2=B1  4%  =
interrupts.CPU72.RES:Rescheduling_interrupts
>>       3939 =C2=B1  3%     +26.0%       4962 =C2=B1  6%  =
interrupts.CPU73.CAL:Function_call_interrupts
>>       5184 =C2=B1  2%     -34.3%       3408 =C2=B1 25%  =
interrupts.CPU73.NMI:Non-maskable_interrupts
>>       5184 =C2=B1  2%     -34.3%       3408 =C2=B1 25%  =
interrupts.CPU73.PMI:Performance_monitoring_interrupts
>>     763.00 =C2=B1  4%     +40.6%       1072 =C2=B1  4%  =
interrupts.CPU73.RES:Rescheduling_interrupts
>>     570.00 =C2=B1  5%     +97.1%       1123 =C2=B1 25%  =
interrupts.CPU73.TLB:TLB_shootdowns
>>       4069 =C2=B1  6%     +21.7%       4954 =C2=B1  3%  =
interrupts.CPU74.CAL:Function_call_interrupts
>>       5223 =C2=B1  3%     -23.9%       3972 =C2=B1 10%  =
interrupts.CPU74.NMI:Non-maskable_interrupts
>>       5223 =C2=B1  3%     -23.9%       3972 =C2=B1 10%  =
interrupts.CPU74.PMI:Performance_monitoring_interrupts
>>     715.33           +53.9%       1101 =C2=B1  5%  =
interrupts.CPU74.RES:Rescheduling_interrupts
>>     526.00 =C2=B1 14%     +90.9%       1004 =C2=B1 11%  =
interrupts.CPU74.TLB:TLB_shootdowns
>>       4034 =C2=B1 10%     +21.5%       4900 =C2=B1  4%  =
interrupts.CPU75.CAL:Function_call_interrupts
>>       5241 =C2=B1  2%     -42.9%       2995 =C2=B1 37%  =
interrupts.CPU75.NMI:Non-maskable_interrupts
>>       5241 =C2=B1  2%     -42.9%       2995 =C2=B1 37%  =
interrupts.CPU75.PMI:Performance_monitoring_interrupts
>>     712.00 =C2=B1  2%     +49.6%       1065 =C2=B1  6%  =
interrupts.CPU75.RES:Rescheduling_interrupts
>>       4203 =C2=B1  8%     +18.8%       4995 =C2=B1  5%  =
interrupts.CPU76.CAL:Function_call_interrupts
>>       5216 =C2=B1  2%     -32.4%       3525 =C2=B1 31%  =
interrupts.CPU76.NMI:Non-maskable_interrupts
>>       5216 =C2=B1  2%     -32.4%       3525 =C2=B1 31%  =
interrupts.CPU76.PMI:Performance_monitoring_interrupts
>>     719.00 =C2=B1  2%     +44.5%       1039 =C2=B1  5%  =
interrupts.CPU76.RES:Rescheduling_interrupts
>>     488.00 =C2=B1 10%     +87.1%     913.25 =C2=B1  9%  =
interrupts.CPU76.TLB:TLB_shootdowns
>>       3955 =C2=B1  7%     +23.9%       4901 =C2=B1  3%  =
interrupts.CPU77.CAL:Function_call_interrupts
>>       5224 =C2=B1  3%     -24.5%       3944 =C2=B1 11%  =
interrupts.CPU77.NMI:Non-maskable_interrupts
>>       5224 =C2=B1  3%     -24.5%       3944 =C2=B1 11%  =
interrupts.CPU77.PMI:Performance_monitoring_interrupts
>>     703.67 =C2=B1  8%     +50.9%       1062 =C2=B1  3%  =
interrupts.CPU77.RES:Rescheduling_interrupts
>>     466.67 =C2=B1  7%    +125.8%       1053 =C2=B1 13%  =
interrupts.CPU77.TLB:TLB_shootdowns
>>       4189 =C2=B1  6%     +15.8%       4852 =C2=B1  6%  =
interrupts.CPU78.CAL:Function_call_interrupts
>>       5190 =C2=B1  4%     -33.4%       3455 =C2=B1 24%  =
interrupts.CPU78.NMI:Non-maskable_interrupts
>>       5190 =C2=B1  4%     -33.4%       3455 =C2=B1 24%  =
interrupts.CPU78.PMI:Performance_monitoring_interrupts
>>     706.00           +49.5%       1055 =C2=B1  4%  =
interrupts.CPU78.RES:Rescheduling_interrupts
>>     442.67 =C2=B1  8%    +135.9%       1044 =C2=B1 15%  =
interrupts.CPU78.TLB:TLB_shootdowns
>>       3902 =C2=B1  3%     +24.7%       4865 =C2=B1  3%  =
interrupts.CPU79.CAL:Function_call_interrupts
>>       5225 =C2=B1  3%     -35.1%       3390 =C2=B1 24%  =
interrupts.CPU79.NMI:Non-maskable_interrupts
>>       5225 =C2=B1  3%     -35.1%       3390 =C2=B1 24%  =
interrupts.CPU79.PMI:Performance_monitoring_interrupts
>>     704.67 =C2=B1  4%     +58.3%       1115 =C2=B1  7%  =
interrupts.CPU79.RES:Rescheduling_interrupts
>>     444.00 =C2=B1 13%    +111.1%     937.25 =C2=B1 11%  =
interrupts.CPU79.TLB:TLB_shootdowns
>>       4089 =C2=B1  4%     +19.8%       4898        =
interrupts.CPU8.CAL:Function_call_interrupts
>>       5181 =C2=B1  4%     -22.3%       4024 =C2=B1  5%  =
interrupts.CPU8.NMI:Non-maskable_interrupts
>>       5181 =C2=B1  4%     -22.3%       4024 =C2=B1  5%  =
interrupts.CPU8.PMI:Performance_monitoring_interrupts
>>     785.33 =C2=B1  4%     +41.3%       1110 =C2=B1  6%  =
interrupts.CPU8.RES:Rescheduling_interrupts
>>     480.00 =C2=B1  9%     +94.0%     931.00 =C2=B1 17%  =
interrupts.CPU8.TLB:TLB_shootdowns
>>       4093 =C2=B1  6%     +22.6%       5018 =C2=B1  4%  =
interrupts.CPU80.CAL:Function_call_interrupts
>>     721.33 =C2=B1  5%     +44.9%       1045 =C2=B1  2%  =
interrupts.CPU80.RES:Rescheduling_interrupts
>>     485.33 =C2=B1 10%    +101.9%     980.00 =C2=B1  6%  =
interrupts.CPU80.TLB:TLB_shootdowns
>>       4059 =C2=B1  9%     +19.3%       4843 =C2=B1  4%  =
interrupts.CPU81.CAL:Function_call_interrupts
>>       5243 =C2=B1  3%     -25.7%       3894 =C2=B1 10%  =
interrupts.CPU81.NMI:Non-maskable_interrupts
>>       5243 =C2=B1  3%     -25.7%       3894 =C2=B1 10%  =
interrupts.CPU81.PMI:Performance_monitoring_interrupts
>>     689.67 =C2=B1  7%     +53.0%       1055 =C2=B1  7%  =
interrupts.CPU81.RES:Rescheduling_interrupts
>>     553.67 =C2=B1 16%     +87.9%       1040 =C2=B1 13%  =
interrupts.CPU81.TLB:TLB_shootdowns
>>       3950 =C2=B1  8%     +23.1%       4863 =C2=B1  6%  =
interrupts.CPU82.CAL:Function_call_interrupts
>>       5207 =C2=B1  3%     -33.8%       3447 =C2=B1 25%  =
interrupts.CPU82.NMI:Non-maskable_interrupts
>>       5207 =C2=B1  3%     -33.8%       3447 =C2=B1 25%  =
interrupts.CPU82.PMI:Performance_monitoring_interrupts
>>     723.33           +45.0%       1048 =C2=B1  2%  =
interrupts.CPU82.RES:Rescheduling_interrupts
>>     424.67 =C2=B1 12%    +143.4%       1033 =C2=B1 11%  =
interrupts.CPU82.TLB:TLB_shootdowns
>>       4227 =C2=B1  9%     +20.3%       5085 =C2=B1  6%  =
interrupts.CPU83.CAL:Function_call_interrupts
>>       5224 =C2=B1  3%     -42.6%       2998 =C2=B1 38%  =
interrupts.CPU83.NMI:Non-maskable_interrupts
>>       5224 =C2=B1  3%     -42.6%       2998 =C2=B1 38%  =
interrupts.CPU83.PMI:Performance_monitoring_interrupts
>>     690.00 =C2=B1  7%     +57.2%       1084 =C2=B1  3%  =
interrupts.CPU83.RES:Rescheduling_interrupts
>>     437.33 =C2=B1  9%    +170.6%       1183 =C2=B1 19%  =
interrupts.CPU83.TLB:TLB_shootdowns
>>       4122 =C2=B1 10%     +19.3%       4918 =C2=B1  3%  =
interrupts.CPU84.CAL:Function_call_interrupts
>>       5236 =C2=B1  3%     -44.5%       2906 =C2=B1 29%  =
interrupts.CPU84.NMI:Non-maskable_interrupts
>>       5236 =C2=B1  3%     -44.5%       2906 =C2=B1 29%  =
interrupts.CPU84.PMI:Performance_monitoring_interrupts
>>     714.00 =C2=B1  2%     +49.4%       1066 =C2=B1  4%  =
interrupts.CPU84.RES:Rescheduling_interrupts
>>     460.00 =C2=B1 17%    +124.9%       1034 =C2=B1 11%  =
interrupts.CPU84.TLB:TLB_shootdowns
>>       4072 =C2=B1  5%     +19.5%       4864 =C2=B1  4%  =
interrupts.CPU85.CAL:Function_call_interrupts
>>       5256 =C2=B1  3%     -24.5%       3967 =C2=B1  9%  =
interrupts.CPU85.NMI:Non-maskable_interrupts
>>       5256 =C2=B1  3%     -24.5%       3967 =C2=B1  9%  =
interrupts.CPU85.PMI:Performance_monitoring_interrupts
>>     696.67 =C2=B1  5%     +53.2%       1067 =C2=B1  5%  =
interrupts.CPU85.RES:Rescheduling_interrupts
>>     445.67 =C2=B1 13%    +112.0%     945.00 =C2=B1  2%  =
interrupts.CPU85.TLB:TLB_shootdowns
>>       4091 =C2=B1  3%     +21.3%       4964 =C2=B1  4%  =
interrupts.CPU86.CAL:Function_call_interrupts
>>     699.33 =C2=B1  5%     +56.4%       1093 =C2=B1  4%  =
interrupts.CPU86.RES:Rescheduling_interrupts
>>     466.00 =C2=B1 14%    +126.0%       1053 =C2=B1  4%  =
interrupts.CPU86.TLB:TLB_shootdowns
>>       4003 =C2=B1  8%     +25.3%       5015 =C2=B1  4%  =
interrupts.CPU87.CAL:Function_call_interrupts
>>     687.00 =C2=B1  3%     +54.1%       1058 =C2=B1  5%  =
interrupts.CPU87.RES:Rescheduling_interrupts
>>     474.33 =C2=B1 18%    +116.1%       1025 =C2=B1  9%  =
interrupts.CPU87.TLB:TLB_shootdowns
>>       4087 =C2=B1  8%     +21.9%       4982 =C2=B1  3%  =
interrupts.CPU88.CAL:Function_call_interrupts
>>     695.67           +48.5%       1033 =C2=B1  2%  =
interrupts.CPU88.RES:Rescheduling_interrupts
>>     482.00 =C2=B1 12%    +114.2%       1032 =C2=B1  7%  =
interrupts.CPU88.TLB:TLB_shootdowns
>>       3940 =C2=B1  8%     +25.5%       4944 =C2=B1  5%  =
interrupts.CPU89.CAL:Function_call_interrupts
>>       5209 =C2=B1  3%     -25.2%       3895 =C2=B1 10%  =
interrupts.CPU89.NMI:Non-maskable_interrupts
>>       5209 =C2=B1  3%     -25.2%       3895 =C2=B1 10%  =
interrupts.CPU89.PMI:Performance_monitoring_interrupts
>>     695.67 =C2=B1  4%     +51.6%       1054 =C2=B1  4%  =
interrupts.CPU89.RES:Rescheduling_interrupts
>>     434.00 =C2=B1 15%    +131.6%       1005 =C2=B1  9%  =
interrupts.CPU89.TLB:TLB_shootdowns
>>       3991 =C2=B1  2%     +18.5%       4728 =C2=B1  3%  =
interrupts.CPU9.CAL:Function_call_interrupts
>>       5149 =C2=B1  5%     -33.6%       3418 =C2=B1 25%  =
interrupts.CPU9.NMI:Non-maskable_interrupts
>>       5149 =C2=B1  5%     -33.6%       3418 =C2=B1 25%  =
interrupts.CPU9.PMI:Performance_monitoring_interrupts
>>     704.67 =C2=B1  7%     +56.2%       1100 =C2=B1  4%  =
interrupts.CPU9.RES:Rescheduling_interrupts
>>     433.67 =C2=B1  8%    +107.6%     900.25 =C2=B1 12%  =
interrupts.CPU9.TLB:TLB_shootdowns
>>       4145 =C2=B1  6%     +17.4%       4868 =C2=B1  6%  =
interrupts.CPU90.CAL:Function_call_interrupts
>>       5217 =C2=B1  3%     -42.9%       2977 =C2=B1 40%  =
interrupts.CPU90.NMI:Non-maskable_interrupts
>>       5217 =C2=B1  3%     -42.9%       2977 =C2=B1 40%  =
interrupts.CPU90.PMI:Performance_monitoring_interrupts
>>     672.33 =C2=B1  4%     +61.4%       1085 =C2=B1  2%  =
interrupts.CPU90.RES:Rescheduling_interrupts
>>     491.33 =C2=B1 14%     +90.1%     934.00 =C2=B1  9%  =
interrupts.CPU90.TLB:TLB_shootdowns
>>       4304 =C2=B1  7%     +17.4%       5051 =C2=B1  3%  =
interrupts.CPU91.CAL:Function_call_interrupts
>>     799.00 =C2=B1  4%     +34.7%       1076 =C2=B1  3%  =
interrupts.CPU91.RES:Rescheduling_interrupts
>>     458.33 =C2=B1 13%    +112.6%     974.50 =C2=B1  3%  =
interrupts.CPU91.TLB:TLB_shootdowns
>>       3978 =C2=B1  4%     +21.1%       4816 =C2=B1  3%  =
interrupts.CPU92.CAL:Function_call_interrupts
>>       5190 =C2=B1  4%     -54.3%       2371 =C2=B1 21%  =
interrupts.CPU92.NMI:Non-maskable_interrupts
>>       5190 =C2=B1  4%     -54.3%       2371 =C2=B1 21%  =
interrupts.CPU92.PMI:Performance_monitoring_interrupts
>>     648.00           +66.6%       1079 =C2=B1  4%  =
interrupts.CPU92.RES:Rescheduling_interrupts
>>     470.67 =C2=B1 14%     +99.7%     940.00 =C2=B1 17%  =
interrupts.CPU92.TLB:TLB_shootdowns
>>       3937 =C2=B1  6%     +23.5%       4863 =C2=B1  5%  =
interrupts.CPU93.CAL:Function_call_interrupts
>>       5221 =C2=B1  3%     -35.6%       3365 =C2=B1 23%  =
interrupts.CPU93.NMI:Non-maskable_interrupts
>>       5221 =C2=B1  3%     -35.6%       3365 =C2=B1 23%  =
interrupts.CPU93.PMI:Performance_monitoring_interrupts
>>     677.67 =C2=B1  6%     +53.6%       1041 =C2=B1  5%  =
interrupts.CPU93.RES:Rescheduling_interrupts
>>     481.00 =C2=B1  4%    +123.9%       1077 =C2=B1  4%  =
interrupts.CPU93.TLB:TLB_shootdowns
>>       4005 =C2=B1  5%     +22.8%       4919 =C2=B1  6%  =
interrupts.CPU94.CAL:Function_call_interrupts
>>     648.00 =C2=B1  2%     +61.7%       1047 =C2=B1  6%  =
interrupts.CPU94.RES:Rescheduling_interrupts
>>     469.67 =C2=B1  9%    +103.2%     954.25 =C2=B1 17%  =
interrupts.CPU94.TLB:TLB_shootdowns
>>       4039 =C2=B1  2%     +26.0%       5088 =C2=B1  5%  =
interrupts.CPU95.CAL:Function_call_interrupts
>>     664.00 =C2=B1  8%     +65.4%       1098 =C2=B1  8%  =
interrupts.CPU95.RES:Rescheduling_interrupts
>>     458.00 =C2=B1 18%    +119.0%       1003 =C2=B1  8%  =
interrupts.CPU95.TLB:TLB_shootdowns
>>       3941 =C2=B1  2%     +20.5%       4750 =C2=B1  3%  =
interrupts.CPU96.CAL:Function_call_interrupts
>>       5213 =C2=B1  5%     -26.6%       3824 =C2=B1  9%  =
interrupts.CPU96.NMI:Non-maskable_interrupts
>>       5213 =C2=B1  5%     -26.6%       3824 =C2=B1  9%  =
interrupts.CPU96.PMI:Performance_monitoring_interrupts
>>     707.67 =C2=B1  4%     +69.0%       1196 =C2=B1  4%  =
interrupts.CPU96.RES:Rescheduling_interrupts
>>     453.00 =C2=B1  5%    +111.2%     956.75 =C2=B1  9%  =
interrupts.CPU96.TLB:TLB_shootdowns
>>       3892 =C2=B1  3%     +29.5%       5041 =C2=B1  8%  =
interrupts.CPU97.CAL:Function_call_interrupts
>>       5166 =C2=B1  4%     -25.1%       3867 =C2=B1  9%  =
interrupts.CPU97.NMI:Non-maskable_interrupts
>>    =EF=BF=BD=EF=BF=BD  5166 =C2=B1  4%     -25.1%       3867 =C2=B1  =
9%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
>>     755.67 =C2=B1  8%     +55.6%       1175 =C2=B1  5%  =
interrupts.CPU97.RES:Rescheduling_interrupts
>>     487.00 =C2=B1 10%     +86.1%     906.25 =C2=B1  8%  =
interrupts.CPU97.TLB:TLB_shootdowns
>>       3869 =C2=B1  3%     +23.6%       4782        =
interrupts.CPU98.CAL:Function_call_interrupts
>>       5178 =C2=B1  5%     -34.9%       3369 =C2=B1 24%  =
interrupts.CPU98.NMI:Non-maskable_interrupts
>>       5178 =C2=B1  5%     -34.9%       3369 =C2=B1 24%  =
interrupts.CPU98.PMI:Performance_monitoring_interrupts
>>     687.33 =C2=B1  5%     +68.1%       1155 =C2=B1  4%  =
interrupts.CPU98.RES:Rescheduling_interrupts
>>     389.00 =C2=B1 13%    +121.1%     860.25 =C2=B1  8%  =
interrupts.CPU98.TLB:TLB_shootdowns
>>       4000           +21.9%       4876 =C2=B1  6%  =
interrupts.CPU99.CAL:Function_call_interrupts
>>     719.67           +67.0%       1202 =C2=B1  2%  =
interrupts.CPU99.RES:Rescheduling_interrupts
>>     463.00 =C2=B1  8%     +76.1%     815.50 =C2=B1 10%  =
interrupts.CPU99.TLB:TLB_shootdowns
>>     913220 =C2=B1  2%     -24.1%     693121 =C2=B1  9%  =
interrupts.NMI:Non-maskable_interrupts
>>     913220 =C2=B1  2%     -24.1%     693121 =C2=B1  9%  =
interrupts.PMI:Performance_monitoring_interrupts
>>     132379           +62.4%     215045        =
interrupts.RES:Rescheduling_interrupts
>>      94465 =C2=B1 13%     +95.5%     184704 =C2=B1  9%  =
interrupts.TLB:TLB_shootdowns
>>=20
>>=20
>>=20
>>=20
>>=20
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are =
provided
>> for informational purposes only. Any difference in system hardware or =
software
>> design or configuration may affect actual performance.
>>=20
>>=20
>> Thanks,
>> Oliver Sang
>> _______________________________________________
>> LKP mailing list -- lkp@lists.01.org
>> To unsubscribe send an email to lkp-leave@lists.01.org
>=20
> --=20
> Zhengjun Xing
>=20

