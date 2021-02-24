Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3680B32419B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhBXQCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:02:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47582 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbhBXPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:50:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OFi2MT143654;
        Wed, 24 Feb 2021 15:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7lBDAHEfhhTtSCbJBWubnkHDuHvpBO9SjcwbNo/eIRU=;
 b=GEYG3puFdlqd2LupjeqmcgFq9rvCNPmVYchFh43oygG2rhqktpUTHQgWqzS/shcvwkY/
 vx6BCbURIpzunNmb1Stiy15V+8r3SnjYNhlFVnV9fRmKqQbggT2en2Ru3IqTdCHEzr7p
 u7LW8GTotY3liFEfEA6xt6ijGqfI4of83NXDenobCLLz7VQKZRMYX0iA2ys76vZk8ypW
 JwWN070EJreQeo28R1LeQwPT7Ys9t2Qv8gs0+kvujEYcfB54kO7im6q9c0gBpZ05Dme3
 F8RK9rnzDzMN6Z2x2IazHoE0P9zgq2gIy4Qw9ECOiVFsGOA9v5e1IG53zSG11nLC7Qnw Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ttcmbcn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 15:47:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OFedup117908;
        Wed, 24 Feb 2021 15:47:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36ucb0w00b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 15:47:26 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11OFlDwt012161;
        Wed, 24 Feb 2021 15:47:16 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Feb 2021 07:47:13 -0800
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
From:   chris hyser <chris.hyser@oracle.com>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
 <YDTFWZPdmrDuYd91@hirez.programming.kicks-ass.net>
 <e1ee6187-77a7-dbf2-3e14-adba48460f5b@oracle.com>
 <CABk29NvX9_RxpZ71ihR7Y_Nhpg0TpBfdXzehptO52VuwOmS2Ww@mail.gmail.com>
 <c65bde1e-bac9-e6b6-e6c8-78b93f27b8e4@oracle.com>
 <94f43bb6-501c-2851-de32-6f4356b4a480@oracle.com>
Message-ID: <ef574666-26f4-299e-65c8-2348948651f9@oracle.com>
Date:   Wed, 24 Feb 2021 10:47:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <94f43bb6-501c-2851-de32-6f4356b4a480@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240122
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 8:52 AM, chris hyser wrote:
> On 2/24/21 8:02 AM, Chris Hyser wrote:
> 
>>> However, it means that overall throughput of your binary is cut in
>>> ~half, since none of the threads can share a core. Note that I never
>>> saw an indefinite deadlock, just ~2x runtime for your binary vs th > control. I've verified that both a) manually 
>>> hardcoding all threads to
>>> be able to share regardless of cookie, and b) using a machine with 6
>>> cores instead of 2, both allow your binary to complete in the same
>>> amount of time as without the new API.
>>
>> This was on a 24 core box. When I run the test, I definitely hangs. I'll answer your other email as wwll.
> 
> 
> I just want to clarify. The test completes in secs normally. When I run this on the 24 core box from the console, other 
> ssh connections immediately freeze. The console is frozen. You can't ping the box and it has stayed that way for up to 
> 1/2 hour before I reset it. I'm trying to get some kind of stack trace to see what it is doing. To the extent that I've 
> been able to trace it or print it, the "next code" always seems to be __sched_core_update_cookie(p);

I cannot duplicate this on a 4 core box even with 1000's of processes and threads. The 24 core box does not even create 
the full 400 processes/threads in that test before it hangs and that test reliably fails almost instantly. The working 
theory is that the 24 core box is doing way more of the clone syscalls in parallel.

-chrish
