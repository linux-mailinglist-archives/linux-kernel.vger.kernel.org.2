Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6642FB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbhJOSnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:43:51 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:25970 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234721AbhJOSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:43:49 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FIcLh7000930;
        Fri, 15 Oct 2021 18:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=GxnEXCkHtMusQISLZyc+uXHkSoG1TGbhBZEua24I7Ds=;
 b=YssCJQ/84WTgIx/vYP8uEWA3juaP6Q+J2Fibs3+t8tu5c7YlF1Cfa8hcF8HNQxRRwwvc
 SAUkR/Wfl7uW8rWlG2bv+pVG0uBMTyz8oUKc/b62xjTZGeY7YPVszu1xex/VrMJJyWOD
 b4ABBeE+xvq8B+2X1wZvfxdFkRFwoPHu9Job1yCzXDodZXqgZk8bJUWgupM4tWs2mr6N
 172eKPFOPt8Bjz+Ho8jdXDT0MXknwoYrSGYdyE2geraPoukWl2BHHRSvvLjPENTyW+Wy
 J8R9vY8f/KQCTdUy6WgFh7ZVT0EEhujUTmJJxMIwb0RrTv+qTjL5eZtySI9OHDGfoMQl aA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bq57b8jta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 18:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwU2Ovr8Fum/FqrF7KyMvucG7Ql6CWPgVIEBZ/JbqZnEcDg+v0yGlR+RXOhGgRgukGggeLDs9evrPerzWSDW13NzzWnn4lo8jbISxeK7kQNszh0ab5j9jFueA6uOs6QS1TA4+4gjX90ss7b17ObDQOxnqKtjm6Dno2Ep87nEjN4GV4Wv+5FtAYOkQAk4xbUpcUsvXDWSeMDeYSC6NHU11BHALfJEQPtdeaXEK6WXPYHFRZMwc1hhI5+MmbfYDIW07BM6qC0JX1q/dxJ9VFEpVQwCDP7ySZXHhxLqwJkky5+SsNO9TJM30q0VNTjDyaWEYvUIouqfxucjc1qKTK6g1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxnEXCkHtMusQISLZyc+uXHkSoG1TGbhBZEua24I7Ds=;
 b=ho3VkfWfwRK5LqnvyN5zmJeVET8iRtNKjACAAF75FreekYiiRgACHqp8Bf5wUaCgGh+x36XqVi95Wpxu6p0MYyJYFBmDmlMLc+gJ4tr0Z6rldsaqYCBK865Wv+6aHFHb62LfFIBc2ShgYzEt/jgm+VOeA/eHloUNYs0XwKvb51s+WtIadZJZ9aCuoIUv6obWTApsi1AaD4UaipIX35W/2zY0HYVgDcrowMo37ddG4CNwhAM3XhehmZpWdsUqeQssAjB+rTvHiNcvuGtGC1QoesxWYWNqI0FtccRo/6F2ZiWsza19AuQNGUkFh6BChDdujkdhyGJ2Rl+sDIUA+FQDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB2602.namprd11.prod.outlook.com (2603:10b6:5:c0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Fri, 15 Oct 2021 18:41:24 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%3]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 18:41:24 +0000
Subject: Re: [peterz-queue:locking/core 41/43] kernel/locking/rwsem.c:1023:19:
 error: variable has incomplete type 'enum owner_state'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <202110152145.nWCivoXy-lkp@intel.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <8c0f011a-db83-001e-3cce-326cb8228a75@windriver.com>
Date:   Sat, 16 Oct 2021 02:41:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <202110152145.nWCivoXy-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:203:b0::30) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from [128.224.163.131] (60.247.85.82) by HK0PR03CA0114.apcprd03.prod.outlook.com (2603:1096:203:b0::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:41:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c51a3a-a73d-42a8-ff3f-08d9900b63dc
X-MS-TrafficTypeDiagnostic: DM6PR11MB2602:
X-Microsoft-Antispam-PRVS: <DM6PR11MB26027EC0D64AF87BDC3A7783E4B99@DM6PR11MB2602.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA2Zti2MKCJu8UglVrufUmSf4igTVkmLPa5r0QSGArQHmQUkJbOYz5jMFqm68nJKdjnQz452m1+H5uVLwfrltrGHdS8PDT3IUzcpJ41gfYMDkuXkoOev6CzIPTpkKkRN4GKkApU2caySsaMBTaLglmaAepiaPPuLoDd+5tYEJAyDR3BADtRnoJUSazJJpYDXtM7MMMjrbezr+x0AIOElLUYFHNt/5PXO4w6R9u2PLaJK9bME1YJYXxhEQ0roTfGrxdHhLC7KiTDmZCFaB/srxdZgzETZpNR7DtMfJ0XBNYZY/wvK6mn18LDmtuUSsBkpvGtg86+4CsAlszsBlq6O11fF3uL/sB4qHDB9RfVT1qdp5AXwkJqjVqJGrtH+1LkhodLPU9cjMo44Je71WzqiOqDTLB+97fz/GcQEiu6SiW4J4rn+zPzj+HOUzCmzJG9MmKRqp3/5EX0WkUcsn1MSHdw041JiwAP+CXnrmbBtduGv/xSWMd0LUbuTANcKRzzxERAX6zZvyXy/JxgmM0GvZNcm/fHxLxk64v8m5a6VmphVyxrOL/qKRr0+9E7GZN9WsojOnvYGUh4FZGN4w3Fd336JEUITPxer7zB2tP2G3R45pCRjDm5L5jgXTFKWN33+dSD5Evprlr4VWfrL2AUmvaG3zJqbsPFYIRUdSOvt1Uc88QWYzsvzcRVGbP+nibxR+DDafN/AwrXBsUC5adtvi3n9w95iUyqrYNrP/USJ2W7DAMia6uhtQDe4Tw0ewoDvWT6kCDfu9Z+vvuN2qmJAfNZiNjvXaJaZpMffeis6jYSXeDLAu5AaVPNjMcDO8vHUhU+XO+A9ZBBQktadYW/JcQi8+duU6+LBM55Gri6iSPvisN5riNHth1OV6dsGMu8QxZ3e92eHWuEN64mQH4Jl0IY15ALClV52PMsaWOvIPMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(8936002)(66946007)(26005)(6666004)(956004)(316002)(53546011)(36756003)(6706004)(38100700002)(508600001)(66476007)(2616005)(38350700002)(4326008)(16576012)(186003)(66556008)(86362001)(31696002)(6486002)(2906002)(966005)(6916009)(8676002)(52116002)(31686004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?H0HN4J9v7L3d/hnx383FekNGOk23HqZjmHMkVf06ci+IqZ7Egz7Mpg3m?=
 =?Windows-1252?Q?TuV/DNRKFEVCB+pBpiZOIy3908l0JM7oQA2rBcgweP5u+4RzE7wJcFWw?=
 =?Windows-1252?Q?gKv16I+IU4P+ktpV6mLF+wind8Ypm0eFgaJzpBfLBccXGvS+bERJuxEJ?=
 =?Windows-1252?Q?xJD72TSRg5BpauvSF0IFb2HoBlhCu9XHxkMqfSn9N3YjZZy3e3HoCe+E?=
 =?Windows-1252?Q?E+mQVBdqKbM50DvkFBAHpxIJaCZ2r31QOdqhqz0CEQPhh6k33o9VP0W3?=
 =?Windows-1252?Q?Xdz3hzbp9LjZbMiJ4SC20K+S+b/eYBefoU1fzsSb/b4G7S/swCkKax68?=
 =?Windows-1252?Q?jXPklj/DDOmsP9JeVahjVc545gJ4x6VSnAy/wP7OhAENZ3WVT08k6G7m?=
 =?Windows-1252?Q?1Ed800yTt27RBQ63DJxCbcoUKDgPLziFYTpFvOlG1nLu7NF8zL7ypjBz?=
 =?Windows-1252?Q?CnyxfBzJZqVtUaoZ8Koh1KeCeBglX5XHHw0uCkaRLzdDboGByMIlD5XS?=
 =?Windows-1252?Q?LTxfPZlurhvkuei1Yoxzz06Oh4+JR647/Rws7cEMmGoY/VDfyAysqKRh?=
 =?Windows-1252?Q?qh9gtNnlxpSnHC34R6+SB/co7R7aHsQKrkTsyIs5oeAYGrpkJV9/WJUj?=
 =?Windows-1252?Q?/ZHFtsfKUp44BlhV7dx1+XDzzlYwPLunUwFnSUVfuFzewRK1/xp9ehoS?=
 =?Windows-1252?Q?CPtnDsHxtE0sLl2qOw6W4Dpw9akckAWk3Km5RcFVD1O36EZdTuBpkk4R?=
 =?Windows-1252?Q?FVSpBTyGHreAYcw1zsrzZtJ9fbsqsYEZpiKgmuTQfiTguS+BmMwwiecZ?=
 =?Windows-1252?Q?Gspq/0GeyWPTuj/omGxmsuv7KKF/QpOOHVLG5GChmCmwkqLaCKcrWY8L?=
 =?Windows-1252?Q?BjKMITSmVku6LLpXO6z+svdS4424qGymVKOZOxhB0ZD+8S66w49EjyPG?=
 =?Windows-1252?Q?mSRTpKdsjymDueTA4MW7B+QXYZogVy1DU4DfoFUrO6bdi1gDRJ2jX3mW?=
 =?Windows-1252?Q?jDJ0+nm2WfebDt9ZOrrROvdVSXqxiZbNK949IlgkpmLzFf7fid0IrWFh?=
 =?Windows-1252?Q?DYpuCL0nqwvyZAWW0qEpRCmPn0gmq2LTDnU/fUyFGsiIZXbqsMnMuqDF?=
 =?Windows-1252?Q?ZBBU/LOkUaNSo+66r1VjhfGr90PznAh8nYmsCjT7C4VkBFLPAnz4TaXr?=
 =?Windows-1252?Q?uX5fEG6bL0JdbI8GZx5hS0s366dVlNFzymkOxX8DrNtezbgo2tJTz5Wq?=
 =?Windows-1252?Q?byxPR04iyvCe/y62wT/NSF520oWcLO8UXhqk2SAipqAa9FscT8hE1evj?=
 =?Windows-1252?Q?LK81bjXgbSmuJeIHWOE1ziLYhKLWatui2y58mzB4JzcwG51KCYQX2ayT?=
 =?Windows-1252?Q?+rxHVCworXv8Pb1Y7Fx0rEA9jL4yGGM0rgiTfouWd8VnaMHW2CUScLbc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c51a3a-a73d-42a8-ff3f-08d9900b63dc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:41:24.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4cT1fUdyv/3QSXkFNcNfXiYHw4X10ZtIG9qMuffgLoiZP+Beuc+zCV/RCVIjnCFj+F2DPv+7GR+LhLpVrfvHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2602
X-Proofpoint-ORIG-GUID: 6LyB1HL3cAAWb9X2w7lBOYugKUnxt-Hl
X-Proofpoint-GUID: 6LyB1HL3cAAWb9X2w7lBOYugKUnxt-Hl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_06,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/21 9:51 PM, kernel test robot wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> head:   44e63f63c47dfb202eb25cdd97d04ec7e47f51d8
> commit: b08614038dba3f6982e1e7701f23784bb0aedba6 [41/43] locking/rwsem: disable preemption for spinning region
> config: hexagon-randconfig-r041-20211014 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project acb3b187c4c88650a6a717a1bcb234d27d0d7f54)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=b08614038dba3f6982e1e7701f23784bb0aedba6
>          git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>          git fetch --no-tags peterz-queue locking/core
>          git checkout b08614038dba3f6982e1e7701f23784bb0aedba6
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/locking/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel/locking/rwsem.c:1023:19: error: variable has incomplete type 'enum owner_state'
>             enum owner_state owner_state;
>                              ^
>     kernel/locking/rwsem.c:1023:7: note: forward declaration of 'enum owner_state'
>             enum owner_state owner_state;
>                  ^
>     1 error generated.
> 


Hi Peter,

I send a patch named ("locking/rwsem: Introduce 
__rwsem_spin_on_owner()") for fixing this.

Thanks,
Yanfei

> 
> vim +1023 kernel/locking/rwsem.c
> 
>    1012
>    1013  /*
>    1014   * Wait until we successfully acquire the write lock
>    1015   */
>    1016  static struct rw_semaphore *
>    1017  rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>    1018  {
>    1019          long count;
>    1020          enum writer_wait_state wstate;
>    1021          struct rwsem_waiter waiter;
>    1022          struct rw_semaphore *ret = sem;
>> 1023          enum owner_state owner_state;
>    1024          DEFINE_WAKE_Q(wake_q);
>    1025
>    1026          /* do optimistic spinning and steal lock if possible */
>    1027          if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
>    1028                  /* rwsem_optimistic_spin() implies ACQUIRE on success */
>    1029                  return sem;
>    1030          }
>    1031
>    1032          /*
>    1033           * Optimistic spinning failed, proceed to the slowpath
>    1034           * and block until we can acquire the sem.
>    1035           */
>    1036          waiter.task = current;
>    1037          waiter.type = RWSEM_WAITING_FOR_WRITE;
>    1038          waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>    1039
>    1040          raw_spin_lock_irq(&sem->wait_lock);
>    1041
>    1042          /* account for this before adding a new element to the list */
>    1043          wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
>    1044
>    1045          list_add_tail(&waiter.list, &sem->wait_list);
>    1046
>    1047          /* we're now waiting on the lock */
>    1048          if (wstate == WRITER_NOT_FIRST) {
>    1049                  count = atomic_long_read(&sem->count);
>    1050
>    1051                  /*
>    1052                   * If there were already threads queued before us and:
>    1053                   *  1) there are no active locks, wake the front
>    1054                   *     queued process(es) as the handoff bit might be set.
>    1055                   *  2) there are no active writers and some readers, the lock
>    1056                   *     must be read owned; so we try to wake any read lock
>    1057                   *     waiters that were queued ahead of us.
>    1058                   */
>    1059                  if (count & RWSEM_WRITER_MASK)
>    1060                          goto wait;
>    1061
>    1062                  rwsem_mark_wake(sem, (count & RWSEM_READER_MASK)
>    1063                                          ? RWSEM_WAKE_READERS
>    1064                                          : RWSEM_WAKE_ANY, &wake_q);
>    1065
>    1066                  if (!wake_q_empty(&wake_q)) {
>    1067                          /*
>    1068                           * We want to minimize wait_lock hold time especially
>    1069                           * when a large number of readers are to be woken up.
>    1070                           */
>    1071                          raw_spin_unlock_irq(&sem->wait_lock);
>    1072                          wake_up_q(&wake_q);
>    1073                          wake_q_init(&wake_q);   /* Used again, reinit */
>    1074                          raw_spin_lock_irq(&sem->wait_lock);
>    1075                  }
>    1076          } else {
>    1077                  atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
>    1078          }
>    1079
>    1080  wait:
>    1081          /* wait until we successfully acquire the lock */
>    1082          set_current_state(state);
>    1083          for (;;) {
>    1084                  if (rwsem_try_write_lock(sem, wstate)) {
>    1085                          /* rwsem_try_write_lock() implies ACQUIRE on success */
>    1086                          break;
>    1087                  }
>    1088
>    1089                  raw_spin_unlock_irq(&sem->wait_lock);
>    1090
>    1091                  /*
>    1092                   * After setting the handoff bit and failing to acquire
>    1093                   * the lock, attempt to spin on owner to accelerate lock
>    1094                   * transfer. If the previous owner is a on-cpu writer and it
>    1095                   * has just released the lock, OWNER_NULL will be returned.
>    1096                   * In this case, we attempt to acquire the lock again
>    1097                   * without sleeping.
>    1098                   */
>    1099                  if (wstate == WRITER_HANDOFF) {
>    1100                          preempt_disable();
>    1101                          owner_state = rwsem_spin_on_owner(sem);
>    1102                          preempt_enable();
>    1103                          if (owner_state == OWNER_NULL)
>    1104                                  goto trylock_again;
>    1105                  }
>    1106
>    1107                  /* Block until there are no active lockers. */
>    1108                  for (;;) {
>    1109                          if (signal_pending_state(state, current))
>    1110                                  goto out_nolock;
>    1111
>    1112                          schedule();
>    1113                          lockevent_inc(rwsem_sleep_writer);
>    1114                          set_current_state(state);
>    1115                          /*
>    1116                           * If HANDOFF bit is set, unconditionally do
>    1117                           * a trylock.
>    1118                           */
>    1119                          if (wstate == WRITER_HANDOFF)
>    1120                                  break;
>    1121
>    1122                          if ((wstate == WRITER_NOT_FIRST) &&
>    1123                              (rwsem_first_waiter(sem) == &waiter))
>    1124                                  wstate = WRITER_FIRST;
>    1125
>    1126                          count = atomic_long_read(&sem->count);
>    1127                          if (!(count & RWSEM_LOCK_MASK))
>    1128                                  break;
>    1129
>    1130                          /*
>    1131                           * The setting of the handoff bit is deferred
>    1132                           * until rwsem_try_write_lock() is called.
>    1133                           */
>    1134                          if ((wstate == WRITER_FIRST) && (rt_task(current) ||
>    1135                              time_after(jiffies, waiter.timeout))) {
>    1136                                  wstate = WRITER_HANDOFF;
>    1137                                  lockevent_inc(rwsem_wlock_handoff);
>    1138                                  break;
>    1139                          }
>    1140                  }
>    1141  trylock_again:
>    1142                  raw_spin_lock_irq(&sem->wait_lock);
>    1143          }
>    1144          __set_current_state(TASK_RUNNING);
>    1145          list_del(&waiter.list);
>    1146          raw_spin_unlock_irq(&sem->wait_lock);
>    1147          lockevent_inc(rwsem_wlock);
>    1148
>    1149          return ret;
>    1150
>    1151  out_nolock:
>    1152          __set_current_state(TASK_RUNNING);
>    1153          raw_spin_lock_irq(&sem->wait_lock);
>    1154          list_del(&waiter.list);
>    1155
>    1156          if (unlikely(wstate == WRITER_HANDOFF))
>    1157                  atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
>    1158
>    1159          if (list_empty(&sem->wait_list))
>    1160                  atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
>    1161          else
>    1162                  rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>    1163          raw_spin_unlock_irq(&sem->wait_lock);
>    1164          wake_up_q(&wake_q);
>    1165          lockevent_inc(rwsem_wlock_fail);
>    1166
>    1167          return ERR_PTR(-EINTR);
>    1168  }
>    1169
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
