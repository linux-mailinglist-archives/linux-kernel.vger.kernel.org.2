Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C02324063
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhBXO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:57:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhBXNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:55:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ODoFEU144545;
        Wed, 24 Feb 2021 13:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kG2vtjsRdoQ+vHTLYj3dcbBFCmpdhzFhVSU1YaNR790=;
 b=LflfjaFmHb/1jY5IyK+xGIvansHoJBoHfBHRwxkWhTBAcKmgsOSOliNZnBfOdPqqpw6v
 BeRq1Iiv/PM/J51Cw4ReROPNd4EpdmU7V8OnwG5H7kJ9Xog2ksNb6m3XS4msFeGUyiQW
 Jz+UmD+caL9KNVPidqHBdNvuhSWJqCVoFeTpyT7q/roxfBFu0SMkM39hbPOL0DRTM+eC
 RnVm/n7cE1kud6tXa/KI7wn12MjMnMZUg4pdgpFxXGcp8E9R1A50T2fThyhKDwacEK6Z
 WXIDnO1V3iQVOM7/41uZzJ97RuYwmHF1sDhvHpKgKBHCaJZqJhv5rB6fV8V8DZlnUk0t lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcmay6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 13:52:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ODoXL4097576;
        Wed, 24 Feb 2021 13:52:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 36v9m5ytat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 13:52:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11ODqHuT019022;
        Wed, 24 Feb 2021 13:52:20 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Feb 2021 05:52:17 -0800
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
Message-ID: <94f43bb6-501c-2851-de32-6f4356b4a480@oracle.com>
Date:   Wed, 24 Feb 2021 08:52:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c65bde1e-bac9-e6b6-e6c8-78b93f27b8e4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 8:02 AM, Chris Hyser wrote:

>> However, it means that overall throughput of your binary is cut in
>> ~half, since none of the threads can share a core. Note that I never
>> saw an indefinite deadlock, just ~2x runtime for your binary vs th > control. I've verified that both a) manually 
>> hardcoding all threads to
>> be able to share regardless of cookie, and b) using a machine with 6
>> cores instead of 2, both allow your binary to complete in the same
>> amount of time as without the new API.
> 
> This was on a 24 core box. When I run the test, I definitely hangs. I'll answer your other email as wwll.


I just want to clarify. The test completes in secs normally. When I run this on the 24 core box from the console, other 
ssh connections immediately freeze. The console is frozen. You can't ping the box and it has stayed that way for up to 
1/2 hour before I reset it. I'm trying to get some kind of stack trace to see what it is doing. To the extent that I've 
been able to trace it or print it, the "next code" always seems to be __sched_core_update_cookie(p);

-chrish




