Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B443FC693
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbhHaLab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241485AbhHaLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630409374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUQkKqMjfe298ENCQGhuXzgC+Ux4Ha/EvNfbeUIte44=;
        b=HH9hzhOcaK0NWgmptkwQoHAQO8pbtovv5GRxXYIjAIw4XJgM0IXeOko2Ej+afGa2t+XCEP
        ZI0Pgkfxewyr/iyxX/wAbnEVqPBVnNMBUBvFItN9wn9XAaQcWGJfkK/VRXjtU4myBmmf6F
        1l0Xm3VTX+6LUC31zCA0gtaVM1JUJR0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-Ou9bzEMJP06U80unYW6cwQ-1; Tue, 31 Aug 2021 07:29:33 -0400
X-MC-Unique: Ou9bzEMJP06U80unYW6cwQ-1
Received: by mail-wm1-f71.google.com with SMTP id j33-20020a05600c48a100b002e879427915so5848581wmp.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 04:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUQkKqMjfe298ENCQGhuXzgC+Ux4Ha/EvNfbeUIte44=;
        b=qSrnMmEMalgZzrCRYG/PBQdH1bjpkvPVlWQNPzNdliTAqlqSpYX2xc/N81za+vIlLT
         jNJKkuRh0xwwBNqEs5o8Grlf7+OCL003mNv+x/B+nzfCAjfE1KUe7wSFRTrtJgk+XsEJ
         x85sRkXqx5w8KdIP1H3NDtZ5zQxm+bJcu8pDmFezrP5OD5XBsVxUMHD0eM40jiZuPp63
         X94mLhWQL1FpeGhTxT7SqykuoUfk+q0l4Jjh78hpc8k3ObA+GiI2t683Hml0UmNQTjIq
         444s87gkaV92KoyCUv08cgamU/Luqf87K+x9+xh0+nHsetqVPM1SKJ4tufph6hgOnTAl
         tW8g==
X-Gm-Message-State: AOAM530FzNzuR4yiKBj2AK4hs4N1nC54Nf5SZhbrkScnapEd5pWuV1Lr
        eoBesi2NUtxYidw3X1m390UGI8ORbVsI/v3KzEmMl5ZNUq0UW22yF9p0KgzO90hOF9qu4kdFgOP
        p7LplsfP9G0ba3A1VThBh8o7GjhDJwM52nwMp8DNiXnht/Oprz1vgXUDK2AQx9WZlEwExhbz4go
        NmSqk=
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr21569450wrc.12.1630409371182;
        Tue, 31 Aug 2021 04:29:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE4dJn7Il4l4172T4YW2K473bO+NXLR0F9xs6/IuRo9TGASjwpkF43dqGwwBJ0Z7jpwSFwFA==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr21569415wrc.12.1630409370896;
        Tue, 31 Aug 2021 04:29:30 -0700 (PDT)
Received: from ?IPv6:2a02:8388:7c7:5f90:7739:aa20:ea50:9349? (2a02-8388-07c7-5f90-7739-aa20-ea50-9349.cable.dynamic.v6.surfer.at. [2a02:8388:7c7:5f90:7739:aa20:ea50:9349])
        by smtp.gmail.com with ESMTPSA id m3sm22931710wrg.45.2021.08.31.04.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 04:29:30 -0700 (PDT)
Subject: Re: [PATCH] perf: flamegraph.py script improvements
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210830164729.116049-1-agerstmayr@redhat.com>
 <YS0nYpDjPJwT1XYo@kernel.org>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
Message-ID: <de52c3d8-f540-bcbd-6cdf-c2cdecbbc550@redhat.com>
Date:   Tue, 31 Aug 2021 13:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YS0nYpDjPJwT1XYo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.21 20:45, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 30, 2021 at 06:47:27PM +0200, Andreas Gerstmayr escreveu:
>> * display perf.data header
>> * display PIDs of user stacks
>> * added option to change color scheme
>> * default to blue/green color scheme to improve accessibility
>> * correctly identify kernel stacks when kernel-debuginfo is installed
> 
> I'll apply this but please next time split these changes in separate
> patches, this way we can find and fix problems faster by using 'git
> bisect'.

Ok, I'll do that next time.

Thanks for merging!


Cheers,
Andreas


> 
> - Arnaldo
>   
>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>> ---
>> Tested with Fedora 34, RHEL 8.5 & 9-beta, and Ubuntu 20.04.
>>
>> The updated flamegraph.py script works with the current d3-flame-graph template, but in order to use the new features (perf header, new color scheme), please run `wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html https://gist.githubusercontent.com/andreasgerstmayr/1f84a6ac04e6391bfc653a546cf3e1aa/raw/f67accc1873be66d14e90360c9b8cd15faa551f6/d3-flamegraph-base.html`
>> I'll update the js-d3-flame-graph package soon.
>>
>>
>>   tools/perf/scripts/python/flamegraph.py | 108 ++++++++++++++++++------
>>   1 file changed, 81 insertions(+), 27 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
>> index 65780013f745..b6af1dd5f816 100755
>> --- a/tools/perf/scripts/python/flamegraph.py
>> +++ b/tools/perf/scripts/python/flamegraph.py
>> @@ -13,6 +13,10 @@
>>   # Written by Andreas Gerstmayr <agerstmayr@redhat.com>
>>   # Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
>>   # Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
>> +#
>> +# pylint: disable=missing-module-docstring
>> +# pylint: disable=missing-class-docstring
>> +# pylint: disable=missing-function-docstring
>>   
>>   from __future__ import print_function
>>   import sys
>> @@ -20,16 +24,19 @@ import os
>>   import io
>>   import argparse
>>   import json
>> +import subprocess
>>   
>> -
>> +# pylint: disable=too-few-public-methods
>>   class Node:
>> -    def __init__(self, name, libtype=""):
>> +    def __init__(self, name, libtype):
>>           self.name = name
>> +        # "root" | "kernel" | ""
>> +        # "" indicates user space
>>           self.libtype = libtype
>>           self.value = 0
>>           self.children = []
>>   
>> -    def toJSON(self):
>> +    def to_json(self):
>>           return {
>>               "n": self.name,
>>               "l": self.libtype,
>> @@ -41,7 +48,7 @@ class Node:
>>   class FlameGraphCLI:
>>       def __init__(self, args):
>>           self.args = args
>> -        self.stack = Node("root")
>> +        self.stack = Node("all", "root")
>>   
>>           if self.args.format == "html" and \
>>                   not os.path.isfile(self.args.template):
>> @@ -53,13 +60,21 @@ class FlameGraphCLI:
>>                     file=sys.stderr)
>>               sys.exit(1)
>>   
>> -    def find_or_create_node(self, node, name, dso):
>> -        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
>> -        if name is None:
>> -            name = "[unknown]"
>> +    @staticmethod
>> +    def get_libtype_from_dso(dso):
>> +        """
>> +        when kernel-debuginfo is installed,
>> +        dso points to /usr/lib/debug/lib/modules/*/vmlinux
>> +        """
>> +        if dso and (dso == "[kernel.kallsyms]" or dso.endswith("/vmlinux")):
>> +            return "kernel"
>>   
>> +        return ""
>> +
>> +    @staticmethod
>> +    def find_or_create_node(node, name, libtype):
>>           for child in node.children:
>> -            if child.name == name and child.libtype == libtype:
>> +            if child.name == name:
>>                   return child
>>   
>>           child = Node(name, libtype)
>> @@ -67,30 +82,65 @@ class FlameGraphCLI:
>>           return child
>>   
>>       def process_event(self, event):
>> -        node = self.find_or_create_node(self.stack, event["comm"], None)
>> +        pid = event.get("sample", {}).get("pid", 0)
>> +        # event["dso"] sometimes contains /usr/lib/debug/lib/modules/*/vmlinux
>> +        # for user-space processes; let's use pid for kernel or user-space distinction
>> +        if pid == 0:
>> +            comm = event["comm"]
>> +            libtype = "kernel"
>> +        else:
>> +            comm = "{} ({})".format(event["comm"], pid)
>> +            libtype = ""
>> +        node = self.find_or_create_node(self.stack, comm, libtype)
>> +
>>           if "callchain" in event:
>> -            for entry in reversed(event['callchain']):
>> -                node = self.find_or_create_node(
>> -                    node, entry.get("sym", {}).get("name"), event.get("dso"))
>> +            for entry in reversed(event["callchain"]):
>> +                name = entry.get("sym", {}).get("name", "[unknown]")
>> +                libtype = self.get_libtype_from_dso(entry.get("dso"))
>> +                node = self.find_or_create_node(node, name, libtype)
>>           else:
>> -            node = self.find_or_create_node(
>> -                node, entry.get("symbol"), event.get("dso"))
>> +            name = event.get("symbol", "[unknown]")
>> +            libtype = self.get_libtype_from_dso(event.get("dso"))
>> +            node = self.find_or_create_node(node, name, libtype)
>>           node.value += 1
>>   
>> +    def get_report_header(self):
>> +        if self.args.input == "-":
>> +            # when this script is invoked with "perf script flamegraph",
>> +            # no perf.data is created and we cannot read the header of it
>> +            return ""
>> +
>> +        try:
>> +            output = subprocess.check_output(["perf", "report", "--header-only"])
>> +            return output.decode("utf-8")
>> +        except Exception as err:  # pylint: disable=broad-except
>> +            print("Error reading report header: {}".format(err), file=sys.stderr)
>> +            return ""
>> +
>>       def trace_end(self):
>> -        json_str = json.dumps(self.stack, default=lambda x: x.toJSON())
>> +        stacks_json = json.dumps(self.stack, default=lambda x: x.to_json())
>>   
>>           if self.args.format == "html":
>> +            report_header = self.get_report_header()
>> +            options = {
>> +                "colorscheme": self.args.colorscheme,
>> +                "context": report_header
>> +            }
>> +            options_json = json.dumps(options)
>> +
>>               try:
>> -                with io.open(self.args.template, encoding="utf-8") as f:
>> -                    output_str = f.read().replace("/** @flamegraph_json **/",
>> -                                                  json_str)
>> -            except IOError as e:
>> -                print("Error reading template file: {}".format(e), file=sys.stderr)
>> +                with io.open(self.args.template, encoding="utf-8") as template:
>> +                    output_str = (
>> +                        template.read()
>> +                        .replace("/** @options_json **/", options_json)
>> +                        .replace("/** @flamegraph_json **/", stacks_json)
>> +                    )
>> +            except IOError as err:
>> +                print("Error reading template file: {}".format(err), file=sys.stderr)
>>                   sys.exit(1)
>>               output_fn = self.args.output or "flamegraph.html"
>>           else:
>> -            output_str = json_str
>> +            output_str = stacks_json
>>               output_fn = self.args.output or "stacks.json"
>>   
>>           if output_fn == "-":
>> @@ -101,8 +151,8 @@ class FlameGraphCLI:
>>               try:
>>                   with io.open(output_fn, "w", encoding="utf-8") as out:
>>                       out.write(output_str)
>> -            except IOError as e:
>> -                print("Error writing output file: {}".format(e), file=sys.stderr)
>> +            except IOError as err:
>> +                print("Error writing output file: {}".format(err), file=sys.stderr)
>>                   sys.exit(1)
>>   
>>   
>> @@ -115,12 +165,16 @@ if __name__ == "__main__":
>>                           help="output file name")
>>       parser.add_argument("--template",
>>                           default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
>> -                        help="path to flamegraph HTML template")
>> +                        help="path to flame graph HTML template")
>> +    parser.add_argument("--colorscheme",
>> +                        default="blue-green",
>> +                        help="flame graph color scheme",
>> +                        choices=["blue-green", "orange"])
>>       parser.add_argument("-i", "--input",
>>                           help=argparse.SUPPRESS)
>>   
>> -    args = parser.parse_args()
>> -    cli = FlameGraphCLI(args)
>> +    cli_args = parser.parse_args()
>> +    cli = FlameGraphCLI(cli_args)
>>   
>>       process_event = cli.process_event
>>       trace_end = cli.trace_end
>> -- 
>> 2.31.1
> 

