Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D23FD1A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbhIADIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:08:50 -0400
Received: from mail-bn8nam11on2129.outbound.protection.outlook.com ([40.107.236.129]:57344
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240843AbhIADIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVIT82nN5jQYZb5z+BRfFr1gIm0UQ4+oBfLnMiIi60zfL8Muym1PONXSTgVf1KNGCxKm4O/Tk/KagtXELGA2XdwME9DVaOZLGmjQO8cg3FBld5m1AtBFutPwYq3cyQCuxD3ZA2+tDUPKMKZa/XKP/Qc/Z6w+DbVQ7PBe5OkHCAOlakMqzPMjy3Xof36s8SPVagaDvoDbhzPMzFW4WH5x6RkeY7/x1BLRjkIPCF05K9sfLFLMawJo234oxPORm0vD/GsTZqIDcQ9epr8a+MtPQzuDx6DZrA4y5hMCO7jwkb8RPlCC5AEr/MCOBZ6uu9Rv2526dHAVO0uUR5qUnV8tvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf7Goqqt+zoHwhfJBFspaJ3whsb8WqOYIs4e6d6Qj8I=;
 b=Zv7TOCxQjemP1LT+giQnrKbSTx+laUETJ9Isv8tZ03kLZ6sQFI3DSx3Qg6wu8y2/8Y629MNveVeRisr6D3krXNksrMED4/lMLFE/ZA+WWm0AANVfgt5CqpRa5fxDrAi2koeiW7HAAnk5O6VgPBT3QKc3l36n6MQOBNRpIRPl/b4UE9h78KxqYI3jUF9qKTdedjGkB470n6YT4RgzEn1mo/gQ/CaXwE9CrNZNaHziH4GInYBX6zt1/F7Op5LpYDlw/l0L+1a7XjaRe07qLly6kI9nmAVsOJLFJyZtawPCYTZeZPCZ/bsTpYhnBA1PPEwDsDn3m91fAZXtorn1c+TFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf7Goqqt+zoHwhfJBFspaJ3whsb8WqOYIs4e6d6Qj8I=;
 b=zdgXUKpoeJOAdFpTKBgBr+e0SZhnHqwwucc4iHei71IfMk1qpBYotliZrQa1It4hA1GQZeASjVQiOG2V2+MC2imm/8ktt6TidxAymzQtWOxNQt3xNsyXn85/nQ4nsbVrnvx0tFcsS4/TPONKbjFzx4IpD9DLV4Dz/kaGXeCRl6c=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MW4PR01MB6132.prod.exchangelabs.com (2603:10b6:303:7f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Wed, 1 Sep 2021 03:07:50 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56%3]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 03:07:50 +0000
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
Subject: Is it possible to implement the per-node page cache for
 programs/libraries?
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com
Cc:     linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Message-ID: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
Date:   Wed, 1 Sep 2021 11:07:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0170.apcprd02.prod.outlook.com
 (2603:1096:201:1f::30) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.30.33.15] (180.167.209.74) by HK2PR02CA0170.apcprd02.prod.outlook.com (2603:1096:201:1f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 03:07:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df315fab-8baf-4746-f198-08d96cf5ae7c
X-MS-TrafficTypeDiagnostic: MW4PR01MB6132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB6132106706DAFBBCB651CB8CEDCD9@MW4PR01MB6132.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyXwQvM9/bpr5eHQm+f0aMBd53ug3uH5NF4kBxJYwqhdTNJB2OR2rzx7vKajN2dpliT3hqu03LFCZLFH8yWumQxAv9F/fI1pKqd8qEQ8a72GAe6HSu/yT86q/uTOJyBfh6JB1U4mAWJZI5hlSGEy4IkUfgEU5HryXyyWfd6s6oWx70id7awWZHioG2eyBxBmyP5oL9oAjJ67lb5DtUqeVxYVBIDvOQ/L055JrtQubYbgLRZdsIay1E7pz48Ja4ax/gSv4zaitT0kAqMspbw5Z3PrBaz23REaItgcU4INp6gNVkhTKQmNeawr25yOUS1UD8GLRFEpPDAcYAvYMID+OZyvMffBoOB4YRsGJKbKG41mHxWqENGm57F+McQypmjAKU400ji27L0g6ajfjjn4Y6ESwG+ybqfC7MYlvn75nA4cMSQUNvM5gppKUe1sS6vPF3rg1v/4MaeaUNSuP/VuxuJmVdOqANg5Yf+JZFNf6G+pARHT5TqKOvMk0XmPLBZ8MwFJgxoq7YbK4siwKFs8w8Rx/p+RGjquDktorwFpG/Fkr59ygJgkxlbb1EIUYEjMLIUpuiytx0xHsWNVAnQdIo9cmSMYyZ5hwctTUk7tx0N9WTNuw9aG/FXCTbW47GGWGesj2Ij4nrQSuwOWLSiBsQF6odaPsmBnbOYJphVBten6iwuF/dzcAk+jkxgAXzpSW5gbNo9eEYmathPIQeZD6JlJ0FKVuSV0ilDXQKg6ViESXI1cqgSKpMwugBYOb4n8jztuOBFuNbuefOjnmQR4oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(6486002)(26005)(42882007)(83380400001)(5660300002)(83170400001)(186003)(66946007)(4744005)(316002)(16576012)(38350700002)(508600001)(38100700002)(66556008)(66476007)(8676002)(956004)(6666004)(2906002)(31686004)(107886003)(52116002)(2616005)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNqcTc1ci84YmRIYjh1SVZSbUlQYWNDQ3ppZTNuN0lMNEJmQzE4NVh6V3dZ?=
 =?utf-8?B?dXRSSHJ4SndiLytwdlh3cm80TWxycHcxZW5lRUhjWGNHVXVsTVFEMnVkYzhu?=
 =?utf-8?B?WW5OYzBiK2kxNmFWYjZuNEYxZXRDbnJsMCtVV3ZYTXNLQmFsMnp1U2wzM2RT?=
 =?utf-8?B?NFJFV2xQSkVuL1A0VlNmdFF1V0hSNkJ4ZVJ6d20wci91T3FQak9iNzhDK2Ix?=
 =?utf-8?B?Z3lDUjlBdU5BSGowNG9TeGhMZGtLMC9BS0hWaXFJcXh0MUFNQXp1ZjlQaFZP?=
 =?utf-8?B?czR1L1Ayek9PNEg2N3dvTk0yT1drdFFRUlMwV3liUHdQSHU2d05sUzlGN2xw?=
 =?utf-8?B?TXZuTS9rdEtKQ2dJbkRFTXZwM0tMTDFjVGdEUjJ4VUJXa24rVjVjN0hHLzcv?=
 =?utf-8?B?SXlpU3c3SEZHR3RoMlRsZCtTV0Q0TGtPSmM0eXkya0pnejViV1RoODYxRGQ0?=
 =?utf-8?B?c21Wb0N2VkJVcmpKdmFLR0JMZ3Q3cGtVZHhUVlNISWV6YnFMdXlCdWpoSUs3?=
 =?utf-8?B?N29WRkVHbnJJMmV3cEFPOWlMZCs3VVlleWt6UHM3dEkzT0FZcWdmck9SOXBQ?=
 =?utf-8?B?clo3VE9qTHd5SUN2Nm5iOERDTXlMWWs0YlozdDNJNGNCUXh2d2hoalRhS0s5?=
 =?utf-8?B?SllyNG5ING1yeXNDc1o1OWxLQ2dOVVRUaERyTGh5clJRUjZGaU1RSEpDekk2?=
 =?utf-8?B?SGZVU3FjT1FpZXdQaHpjK2tLdXdGZjZFV1QvZEFPdVJUdGNEdzhrRzYvbUZZ?=
 =?utf-8?B?aHVaczVQbDdKYitiLzNwVFNuak5XR21wUENpTjhiWnFrVEgzdHdZbEZRMllx?=
 =?utf-8?B?OXJhM0YyeWU3VzdVU0h4MHdQZThVbTlWVmFmVDF0WG9DSVpMbEVaeG1CNitW?=
 =?utf-8?B?cTFpMjFkOEFWVEJGZm1uUWtyZndiV3FSc2NNamtqdzAwQWJybzV6b0laQWdW?=
 =?utf-8?B?eDNwZko1YW9maCtFdzJPYTh6NjdJOGZaZWpSWStMT3RpTlhISHo2UFh3cE10?=
 =?utf-8?B?aFdkQm44RWpOQnRHbTRScFNSUXdNRmRKZmpseVpLZ2MyakZTZy9mNzR3V0g4?=
 =?utf-8?B?ZVdYam5zVUUvZGFLWWlBc2RWZnJTNDBXcEZ1cUpKNWhEdkFZMklFWDJGNzRm?=
 =?utf-8?B?dEhaa05pSlVpUnpXQmx6K0Vkb3ZUZ1hZank0NWdqV0RMN0ZXY1VPMGIvVVF6?=
 =?utf-8?B?dVNZeTlDa1VjMUtib29UNnRjdkJQcHk2bEFuaFo0MHJxRHAwZGFmWlNTQUR6?=
 =?utf-8?B?QjI2d25VeERUZzk0TFJOc0xSR3NHQkNBU3pUc0Y5bGkwWU1Yc2ZjdW5vL1Zq?=
 =?utf-8?B?Q215NjM5b0Y1OEtwV3VWcHlpcFJFeEp6NllJT04xMzQyZGoyNnREZFdKYkF0?=
 =?utf-8?B?c3BzSWRZdlNQSjN1SW45Qk1uTEdDTnV6SkFONzhGNVJFN09TZXlKUExWb3Ja?=
 =?utf-8?B?aUl2ZS83eTllMVVrM0hJUnc1ZnNsWklPNklrQTNpWmVHMy8vUG9SZVdzWnI0?=
 =?utf-8?B?WjlVNTlMdldjQWFmUitOUFNwRXg0QUdtVUVEZm5icm5tNGlCN1RyWkFHSk8w?=
 =?utf-8?B?c2prejFKU3lxOW9oTDRXNCtQalVhVVB6SzB5RHZnbHZVMk5aMWxvMnN1UDk0?=
 =?utf-8?B?NkkxVXFXWjE0TU4wM0hxSjkvWFR6MkhhZVVJWHpCOVJSZTVSV21CMDhWMWRB?=
 =?utf-8?B?VmR5dk1TcVFEL3c3UUVwbzgzN0I3NmkrWU4xMEdkTXJyR2pQQzVYbkRRalk4?=
 =?utf-8?Q?bdoQrc2WKft8NQSCpsDkGa84wEqFQUuPMjfWamq?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df315fab-8baf-4746-f198-08d96cf5ae7c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 03:07:50.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSnx1+1k7QJh+EK0FMGJo/1Oml5F0qMuBrFG9NxiTQBVTMoQVI1mNToIg56IX5jUG5kYI3SLYoYuLK0B/oSrDraW/oOwlFJzD4s4x7q1IJVX88FC2pgq3SJCQUPd3nZI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

     In the NUMA, we only have one page cache for each file. For the 
program/shared libraries, the

remote-access delays longer then the  local-access.

So, is it possible to implement the per-node page cache for 
programs/libraries?


    We can do it like this:

         1.) Add a new system call to control specific files to 
NUMA-aware, such as:

                    set_numa_aware("/usr/lib/libc.so", enable);

             After the system call, the page cache of libc.so has the 
flags "NUMA_ENABLED"


         2.) When A new process tries to setup the MMU page table for 
libc.so, it will check

              if NUMA_ENABLED is set. If it set, the kernel will give a 
page which is bind to the process's NUMA node.

              By this way, we can eliminate the remote-access for 
programs/shared library.


Is this proposal ok?  Or do you have a better idea?


Thanks

Huang Shijie






